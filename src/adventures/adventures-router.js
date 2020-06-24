const express = require('express')
const AdventuresService = require('../kobold/kobolds-service')
const adventuresRouter = express.Router()
const jsonBodyParser = express.json()

adventuresRouter
    .get('/', jsonBodyParser, (req, res) => {
        const { kobold_level } = req.body

        AdventuresService.getEncoutnerById(req.app.get('db'), kobold_level)
            .then(locations => {
                return res.json(locations)
            })
    })