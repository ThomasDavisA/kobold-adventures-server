const express = require('express')
const KoboldsService = require('./kobolds-service')
const authRouter = express.Router()
const jsonBodyParser = express.json()

koboldsRouter
    .route('/')
    
module.exports = koboldsRouter