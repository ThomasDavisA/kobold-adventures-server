const express = require('express')
const AdventuresService = require('../adventures/adventures-service')
const KoboldsService = require('../kobold/kobolds-service')
const adventuresRouter = express.Router()
const jsonBodyParser = express.json()

adventuresRouter
    .route('/:id')
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
                            return res.json(resolve)
                        }
                        const resolve = {
                            status: false,
                            message: resolution.resolution_fail
                        }
                        return res.json(resolve)
                    })
            })

    })

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