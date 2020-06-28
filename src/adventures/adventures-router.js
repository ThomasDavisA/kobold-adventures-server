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
        AdventuresService.getEncounterByLocation(req.app.get('db'), location_id = 1)
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
                console.log(adventureProgress)
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
    .get((req, res) => {
        const resolution_id = req.params.id
        const kobold_id = req.params.koboldId || 1
        KoboldsService.getKoboldWithKoboldId(req.app.get('db'), kobold_id)
            .then(kobold => {
                const getKobold = kobold
                AdventuresService.getResolutionById(req.app.get('db'), resolution_id)
                    .then(resolution => {
                        let statRoll = 0
                        switch (resolution.resolution_stat) {
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

                        //Send a success or failure based on stats
                        const roll = Math.floor(Math.random() * 20) + statRoll;
                        if (roll >= resolution.resolution_stat) {
                            const resolve = {
                                status: true,
                                message: resolution.resolution_success
                            }

                            const totalProgress = kobold.adventure_progress + 20;
                            const totalNickels = kobold.adventure_nickel_tally + 9;
                            const totalXp = kobold.adventure_xp_tally + 2;
                            const totalScrap = kobold.adventure_scrap_tally;
                            const totalInfluence = kobold.adventure_influence_tally + 2;
                            console.log(totalProgress, kobold.adventure_progress)
                            KoboldsService.updateAdventureWithKoboldId(req.app.get('db'), kobold.kobold_id, totalXp, totalNickels, totalScrap, totalInfluence, totalProgress)
                                .then(ex => {
                                    return res.json(resolve)
                                })

                        } else {
                            const resolve = {
                                status: false,
                                message: resolution.resolution_fail
                            }

                            const totalProgress = kobold.adventure_progress + 10;
                            const totalNickels = kobold.adventure_nickel_tally + 2;
                            const totalXp = kobold.adventure_xp_tally + 8;
                            const totalScrap = kobold.adventure_scrap_tally + 1;
                            const totalInfluence = kobold.adventure_influence_tally + 2;
                            console.log(totalProgress, kobold.adventure_progress)
                            KoboldsService.updateAdventureWithKoboldId(req.app.get('db'), kobold.kobold_id, totalXp, totalNickels, totalScrap, totalInfluence, totalProgress)
                                .then(ex => {
                                    return res.json(resolve)
                                })
                        }


                    })
            })

    })

adventuresRouter
    .route('/rewards/:id')
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
                                console.log(update, toNextLevel)
                                if (update[0].kobold_xp >= toNextLevel) {
                                    console.log('called true')
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

async function checkKoboldLevel(req, xp, level, koboldId) {
    //check out level formula here
    const BASE_XP_FACTOR = 1
    const toNextLevel = (BASE_XP_FACTOR + (((level + BASE_XP_FACTOR) / 2) ** 2))
    console.log(toNextLevel, xp)
    if (xp >= toNextLevel) {
        console.log('called true')
        KoboldsService.updateKoboldLevelWithKoboldId(req.app.get('db'), koboldId)
            .then(res => {
                return true;
            })
    } else {
        return false;
    }
}

async function generateResolutions(req, res, next) {
    try {
        const location_id = req.params.id
        const encountersTable = await AdventuresService.getEncounterByLocation(req.app.get('db'), location_id)

        if (!encountersTable) //Incorrect location_id, default to forest
            encountersTable = await AdventuresService.getEncounterByLocation(req.app.get('db'), 1)

        const encounter = encountersTable[Math.floor(Math.random() * encountersTable.length)]
        let ResolutionsTable = await AdventuresService.getResolutionsByEncounter(req.add.get('db'), encounter.id)

        const ResolutionsList = [];

        //Send back 4 resolutions to return for client to render
        for (i = 0; i < 4; i++) {
            const newResolution = ResolutionsTable[Math.floor(Math.random() * ResolutionsTable.length)]
            ResolutionsList.push(newResolution);
            ResolutionsTable = ResolutionsTable.filter(resolution => resolution.id !== newResolution.id)
        }

        return res.json(encounter, ResolutionsList)
    } catch (error) {
        next(error)
    }
}

module.exports = adventuresRouter