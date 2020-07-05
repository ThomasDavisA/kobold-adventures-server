const knex = require('knex')
const app = require('../src/app')
const helpers = require('./test-helpers')

describe.only('Kobolds endpoints', function () {
    let db

    const testUsers = helpers.makeUsersArray()
    const testKobolds = helpers.makeKoboldsArray()

    const testUser = testUsers[0]

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

    describe('/api/kobolds', () => {
        beforeEach('insert users and kobolds', () => helpers.seedKobolds(db, testKobolds, testUsers))
    })
})