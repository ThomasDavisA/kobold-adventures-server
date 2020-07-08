const express = require('express')
const AdventuresService = require('../adventures/adventures-service')
const KoboldsService = require('../kobold/kobolds-service')
const { requireAuth } = require('../auth/jwt-auth')
const adventuresRouter = express.Router()
const jsonBodyParser = express.json()

adventuresRouter
    .route('/:id')
    .all(requireAuth)
    .get((req, res) => {
        let location_id = req.params.id
        AdventuresService.getEncounterByLocation(req.app.get('db'), location_id)
            .then(Encounters => {
                const encounter = Encounters[Math.floor(Math.random() * Encounters.length)]

                AdventuresService.getResolutionsByEncounter(req.app.get('db'), encounter.encounter_id)
                    .then(ResolutionsTable => {
                        const ResolutionsList = [];

                        //Send back 4 resolutions to return for client to render
                        for (i = 0; i < 4; i++) {
                            const newResolution = ResolutionsTable[Math.floor(Math.random() * ResolutionsTable.length)]
                            ResolutionsList.push(newResolution);
                            ResolutionsTable = ResolutionsTable.filter(resolution => resolution.id !== newResolution.id)
                        }

                        const AdventurePackage = [encounter, ResolutionsList]
                        return res.json(AdventurePackage)
                    })
            })
    })

adventuresRouter
    .route('/:koboldId/progress')
    .all(requireAuth)
    .get((req, res) => {
        const kobold_id = req.params.koboldId
        KoboldsService.getKoboldWithKoboldId(req.app.get('db'), kobold_id)
            .then(kobold => {
                const adventureProgress = kobold.adventure_progress
                return res.json(adventureProgress)
            })
    })

adventuresRouter
    .route('/:koboldId/progress')
    .all(requireAuth)
    .patch(jsonBodyParser, (req, res, next) => {
        const kobold_id = req.params.koboldId
        KoboldsService.clearAdventureProgressWithKoboldId(req.app.get('db'), kobold_id)
            .then(ex => {
                return res.status(204).json()
            })
    })

adventuresRouter
    .route('/resolution/:id/:koboldId')
    .all(requireAuth)
    .get((req, res) => {
        const resolution_id = req.params.id
        const kobold_id = req.params.koboldId || 1
        KoboldsService.getKoboldWithKoboldId(req.app.get('db'), kobold_id)
            .then(kobold => {
                const getKobold = kobold
                AdventuresService.getResolutionById(req.app.get('db'), resolution_id)
                    .then(resolution => {
                        //Send a success or failure based on stats
                        const koboldRoll = getRoll(resolution, kobold)
                        const result = getBonusOrPenalty(koboldRoll, resolution.resolution_stat)

                        let resolve = {}
                        if (result.success) {
                            resolve = {
                                status: true,
                                message: resolution.resolution_success
                            }
                        } else {
                            resolve = {
                                status: false,
                                message: resolution.resolution_fail
                            }
                        }

                        const totalProgress = kobold.adventure_progress + result.advProgress;
                        const totalNickels = kobold.adventure_nickel_tally + result.woodNickels;
                        const totalXp = kobold.adventure_xp_tally + result.koboldXP;
                        const totalScrap = kobold.adventure_scrap_tally + result.equipScrap;
                        const totalInfluence = kobold.adventure_influence_tally + result.dragInfluence;
                        KoboldsService.updateAdventureWithKoboldId(req.app.get('db'), kobold.kobold_id, totalXp, totalNickels, totalScrap, totalInfluence, totalProgress)
                            .then(ex => {
                                return res.json(resolve)
                            })
                    })
            })
    })

adventuresRouter
    .route('/rewards/:id')
    .all(requireAuth)
    .get((req, res) => {
        const koboldId = req.params.id
        KoboldsService.getKoboldWithKoboldId(req.app.get('db'), koboldId)
            .then(kobold => {
                const selectedKobold = kobold
                KoboldsService.updateKoboldCurrencyWithKoboldId(req.app.get('db'), koboldId)
                    .then(update => {
                        KoboldsService.updateKoboldXpWithKoboldId(req.app.get('db'), koboldId)
                            .then(update => {
                                //check out level formula here
                                const BASE_XP_FACTOR = 10
                                const toNextLevel = (BASE_XP_FACTOR + (((selectedKobold.kobold_level + BASE_XP_FACTOR) / 2) ** 2))
                                if (update[0].kobold_xp >= toNextLevel) {
                                    KoboldsService.updateKoboldLevelWithKoboldId(req.app.get('db'), koboldId)
                                        .then(level => {
                                            const rewards = {
                                                xp: selectedKobold.adventure_xp_tally,
                                                nickles: selectedKobold.adventure_nickel_tally,
                                                scrap: selectedKobold.adventure_scrap_tally,
                                                influence: selectedKobold.adventure_influence_tally,
                                                levelUp: true
                                            }
                                            KoboldsService.clearAdventureWithKoboldId(req.app.get('db'), koboldId)
                                                .then(clear => {
                                                    return res.json(rewards)
                                                })
                                        })
                                } else {
                                    const rewards = {
                                        xp: selectedKobold.adventure_xp_tally,
                                        nickles: selectedKobold.adventure_nickel_tally,
                                        scrap: selectedKobold.adventure_scrap_tally,
                                        influence: selectedKobold.adventure_influence_tally,
                                        levelUp: false
                                    }
                                    KoboldsService.clearAdventureWithKoboldId(req.app.get('db'), koboldId)
                                        .then(clear => {
                                            return res.json(rewards)
                                        })
                                }
                            })
                    })
            })
    })

function getRoll(resolution, kobold) {
    //get our roll based on stat, and create the roll based on number given.
    let statRoll = 0
    switch (resolution.resolution_action) {
        case 'Muscle':
            statRoll = kobold.kobold_muscle
            break;
        case 'Fitness':
            statRoll = kobold.kobold_fitness
            break;
        case 'Eloquence':
            statRoll = kobold.kobold_eloquence
            break;
        case 'Intellect':
            statRoll = kobold.kobold_intellect
            break;
        case 'Mana':
            statRoll = kobold.kobold_mana
            break;
    }

    let minValue = Math.floor(statRoll / 7)
    if (minValue <= 0) { minValue = 1 }
    let maxValue = Math.floor(statRoll / 3)
    if (maxValue < 4) { maxValue = 4 }
    let diceValue = Math.floor(statRoll / 20)
    if (diceValue < 1) { diceValue = 1 }

    let roll = 0
    for (i = 0; i < diceValue; i++) {
        roll = roll + (Math.floor(Math.random() * (maxValue - minValue)) + minValue)
    }

    return roll
}

function getBonusOrPenalty(koboldStat, resolutionStat) {
    resolutionStat = parseInt(resolutionStat)
    if (koboldStat < resolutionStat) {
        //calculate penalty to progress and rewards, but gain bonus to xp
        let penalty = (resolutionStat - koboldStat) / resolutionStat
        if (penalty > .5)
            penalty = .5

        const success = false;
        const woodNickels = Math.floor((resolutionStat / 2) - ((resolutionStat / 2) * penalty)) + 1
        const equipScrap = Math.floor((resolutionStat / 10) - ((resolutionStat / 10) * penalty))
        const dragInfluence = Math.floor((resolutionStat / 5) - ((resolutionStat / 5) * penalty)) + 1
        const koboldXP = Math.floor((resolutionStat / 3) + ((resolutionStat / 3) * penalty)) + 1
        const advProgress = Math.floor((resolutionStat) + ((resolutionStat) * penalty))

        const result = {
            success: success,
            woodNickels: woodNickels,
            equipScrap: equipScrap,
            dragInfluence: dragInfluence,
            koboldXP: koboldXP,
            advProgress: advProgress
        }

        return result
    } else {
        //bonus to rewards, penalty to xp
        let bonus = (koboldStat - resolutionStat) / koboldStat
        if (bonus > .5)
            bonus = .5
        const success = true;
        const woodNickels = Math.floor((resolutionStat / 2) + ((resolutionStat / 2) * bonus)) + 1
        const equipScrap = Math.floor((resolutionStat / 10) + ((resolutionStat / 10) * bonus))
        const dragInfluence = Math.floor((resolutionStat / 5) + ((resolutionStat / 5) * bonus)) + 1
        const koboldXP = Math.floor((resolutionStat / 3) - ((resolutionStat / 3) * bonus)) + 1
        const advProgress = Math.floor((resolutionStat) - ((resolutionStat) * bonus))

        const result = {
            success: success,
            woodNickels: woodNickels,
            equipScrap: equipScrap,
            dragInfluence: dragInfluence,
            koboldXP: koboldXP,
            advProgress: advProgress
        }

        return result
    }
}

module.exports = adventuresRouter