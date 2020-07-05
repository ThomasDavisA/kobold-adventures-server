const knex = require('knex')
const app = require('../src/app')
const helpers = require('./test-helpers')

describe('Locations endpoints', function () {
    let db

    const testUsers = helpers.makeUsersArray()
    const testLocations = helpers.makeLocationsArray()

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

    context('/api/adventure', () => {
        beforeEach('insert users', () => helpers.seedUsers(db, testUsers))
        beforeEach('insert locations', () => helpers.seedLocations(db, testLocations))

        it('GET returns a list of locations', () => {
            return supertest(app)
                .get('/api/locations/')
                .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                .expect(200)
                .expect(res => {
                    expect(res.body).to.be.an('array')
                    expect(res.body[0]).to.be.an('object')
                    expect(res.body[0].location_id).to.eql(testLocations[0].location_id)
                    expect(res.body[0].location_name).to.eql(testLocations[0].location_name)
                    expect(res.body[0].location_description).to.eql(testLocations[0].location_description)
                    expect(res.body[0].location_level).to.eql(testLocations[0].location_level)
                })
        })
    })
})