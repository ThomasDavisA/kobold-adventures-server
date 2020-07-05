const knex = require('knex')
const app = require('../src/app')
const helpers = require('./test-helpers')

describe('Adventures endpoints', function () {
    let db

    const testUsers = helpers.makeUsersArray()
    const testKobolds = helpers.makeKoboldsArray()
    const testLocations = helpers.makeLocationsArray()
    const testEncounters = helpers.makeEncountersArray()
    const testResolutions = helpers.makeResolutionsArray()

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

    context('/api/adventure', () => {
        beforeEach('insert users and kobolds', () => helpers.seedKobolds(db, testKobolds, testUsers))
        beforeEach('insert encounters, locations, and resolutions', () => helpers.seedResolutions(db, testLocations, testEncounters, testResolutions))

        it('GET returns an encounter when provided a location id', () => {
            return supertest(app)
                .get('/api/adventure/1')
                .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                .expect(200)
                .expect(res => {
                    expect(res.body).to.be.an('array')
                    expect(res.body[0]).to.be.an('object')
                    expect(res.body[0].location_id).to.eql(testEncounters[0].location_id)
                    expect(res.body[1]).to.be.an('array')
                })
        })

        it('GET returns the adventure progress of a kobold when provided a kobold id', () => {
            return supertest(app)
                .get('/api/adventure/1/progress')
                .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                .expect(200)
                .expect(res => {
                    expect(res.body).to.eql(testKobolds[0].adventure_progress)
                })
        })

        it('PATCH set kobold adventure progress to zero of a kobold when provided a kobold id', () => {
            return supertest(app)
                .patch('/api/adventure/1/progress')
                .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                .expect(204)
                .then(() => {
                    return supertest(app)
                    .get('/api/kobold/')
                    .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                    .expect(res => {
                        expect(res.body.adventure_progress).to.eql(0)
                    })
                })
        })

        it('GET returns a resolution fail or success based on a kobold id and resolution', () => {
            return supertest(app)
                .get('/api/adventure/resolution/1/1')
                .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                .expect(200)
                .expect(res => {
                    expect(res.body).to.be.an('object')
                    expect(res.body.status).to.exist
                    expect(res.body.message).to.exist
                    // then(() => {
                    //     return supertest(app)
                    //     .get('/api/kobold/')
                    //     .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                    //     .expect(res => {
                    //         expect(res.body.adventure_progress).to.be.above(0)
                    //     })
                    // })
                })
        })

        it('GET returns rewards when given a kobold id', () => {
            return supertest(app)
                .get('/api/adventure/rewards/1')
                .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                .expect(200)
                .expect(res => {
                    expect(res.body).to.be.an('object')
                    expect(res.body.xp).to.eql(0)
                    expect(res.body.nickles).to.eql(0)
                    expect(res.body.scrap).to.eql(0)
                    expect(res.body.influence).to.eql(0)
                    expect(res.body.levelUp).to.be.true
                })

        })

    })
})