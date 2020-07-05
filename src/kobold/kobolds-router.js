const express = require('express')
const KoboldsService = require('./kobolds-service')
const AuthService = require('../auth/auth-service')
const { requireAuth } = require('../auth/jwt-auth')
const koboldsRouter = express.Router()
const jsonBodyParser = express.json()


koboldsRouter
    .route('/')
    .get((req, res) => {
        const authToken = req.get('authorization')
        let bearerToken = authToken.slice(7, authToken.length)
        const token = AuthService.verifyJwt(bearerToken)

        KoboldsService.getKoboldWithUsername(req.app.get('db'), token.sub)
            .then(kobold => res.json(kobold))
    })

koboldsRouter
    .route('/')
    .post(jsonBodyParser, (req, res) => {
        const { username } = req.body
        AuthService.getUserWithUserName(req.app.get('db'), username)
            .then(user => {
                KoboldsService.createKoboldWithUser(req.app.get('db'), user)
                    .then(kobold => {
                        return res.json(kobold)
                    })
            })
    })

koboldsRouter
    .route('/:id')
    .all(requireAuth)
    .get((req, res) => {
        KoboldsService.getKoboldWithKoboldId(req.app.get('db'), req.params.id)
            .then(kobold => {
                return res.json(kobold)
            })
    })
    .patch(jsonBodyParser, (req, res) => {
        const koboldStats = req.body
        KoboldsService.updateKoboldStatsWithKoboldId(req.app.get('db'), req.params.id, koboldStats)
            .then(ex => {
                return res.status(204).send()
            })
    })

module.exports = koboldsRouter