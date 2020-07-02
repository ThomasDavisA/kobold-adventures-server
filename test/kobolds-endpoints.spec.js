const knex = require('knex')
const jwt = require('jsonwebtoken')
const app = require('../src/app')
const helpers = require('./test-helpers')

describe('Kobolds endpoints', function () {
    let db
    
    //const { testUsers } = helpers.makeUsersFixtures()
    //const testUser = testUsers[0]

    before('Make knex instance', () => {
        db = knex({
            client: 'pg',
            connection: process.env.TEST_DATABASE_URL,
        })
        app.set('db', db)
    })

    after('disconnect from db', () => db.destroy())
    before('cleanup', () => helpers.cleanTables(db))
    afterEach('cleanup', () => helpers.cleanTables(db))

    describe('GET /api/kobolds', () => {
        beforeEach('insert users', () =>
        helpers.seedUsers(
            db, testUsers
        ))

        it('responds with a kobold when called', () => {
            
        })
    })
})