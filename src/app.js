require('dotenv').config()
const express = require('express')
const morgan = require('morgan')
const cors = require('cors')
const helmet = require('helmet')
const { NODE_ENV } = require('./config')

const authRouter = require('./auth/auth-router')
const koboldsRouter = require('./kobold/kobolds-router')
const locationsRouter = require('./locations/locations-router')
const adventuresRouter = require('./adventures/adventures-router')
const usersRouter = require ('./users/users-router')

const app = express()

const morganOption = (NODE_ENV === 'production')
    ? 'tiny'
    : 'common';

app.use(morgan(morganOption))
app.use(helmet())
app.use(cors())

app.use('/api/auth', authRouter)
app.use('/api/users', usersRouter)
//app.use('/api/locations', locationsRouter)
app.use('/api/adventure', adventuresRouter)
app.use('/api/kobold', koboldsRouter)

app.use(function errorHandler(error, req, res, next) {
    let response
    if (NODE_ENV === 'production') {
        response = { error: { message: 'server error' } }
    } else {
        console.error(error)
        response = { message: error.message, error }
    }
    res.status(500).json(response)
})


module.exports = app