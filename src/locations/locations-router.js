const express = require('express')
const LocationsService = require('../kobold/kobolds-service')
const locationsRouter = express.Router()
const jsonBodyParser = express.json()

locationsRouter
    .get('/location', jsonBodyParser, (req, res) => {
        const { kobold_level } = req.body

        LocationsService.getLocationByLevel(req.app.get('db'), kobold_level)
            .then(locations => {
                return res.json(locations)
            })
    })