const express = require('express')
const KoboldsService = require('./kobolds-service')
const koboldsRouter = express.Router()
const jsonBodyParser = express.json()

koboldsRouter
    .route('/:id')
    .get((req, res) => {
        KoboldsService.getKoboldWithKoboldId(req.app.get('db'), req.params.id)
            .then(kobold => {
                return res.json(kobold)
            })
    })
    .patch(jsonBodyParser, (req, res, next) => {
        const koboldStats = req.body
        KoboldsService.updateKoboldStatsWithKoboldId(req.app.get('db'), req.params.id, koboldStats)
            .then(ex => {
                return res.status(204).send()
            })
    })
    
module.exports = koboldsRouter