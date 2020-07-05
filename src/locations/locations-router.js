const express = require('express')
const LocationsService = require('../locations/locations-service')
const locationsRouter = express.Router()
const { requireAuth } = require('../auth/jwt-auth')
const jsonBodyParser = express.json()

locationsRouter
    .route('/')
    .all(requireAuth)
    .get(jsonBodyParser, (req, res) => {
        
        LocationsService.getLocations(req.app.get('db'))
            .then(locations => {
                return res.json(locations)
            })
    })

module.exports = locationsRouter