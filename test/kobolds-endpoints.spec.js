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

        it('GET responds with a kobold when called', () => {
            return supertest(app)
                .get('/api/kobold/')
                .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                .expect(200)
                .expect(res => {
                    expect(res.body).to.be.an('object')
                    expect(res.body.kobold_id).to.eql(testKobolds[0].kobold_id)
                    expect(res.body.user_id).to.eql(testKobolds[0].user_id)
                    expect(res.body.kobold_level).to.eql(testKobolds[0].kobold_level)
                    expect(res.body.kobold_xp).to.eql(testKobolds[0].kobold_xp)
                    expect(res.body.kobold_unspent_points).to.eql(testKobolds[0].kobold_unspent_points)
                })
        })

        it('POST with username currently in the database returns a new kobold', () => {
            const testUserPost = {
                username: testUsers[0].username,
                password: testUsers[0].password
            }

            return supertest(app)
                .post('/api/kobold/')
                .send(testUserPost)
                .expect(200)
                .expect(res => {
                    expect(res.body).to.be.an('object')
                    expect(res.body.kobold_name).to.eql(testUsers[0].username)
                    expect(res.body.kobold_id).to.eql(4)
                    expect(res.body.user_id).to.eql(testUsers[0].user_id)
                    expect(res.body.kobold_level).to.eql(1)
                    expect(res.body.kobold_xp).to.eql(0)
                    expect(res.body.kobold_unspent_points).to.eql(0)
                })
        })

        it('GETS a kobold when provided the kobold id', () => {
            return supertest(app)
                .get('/api/kobold/1')
                .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                .expect(200)
                .expect(res => {
                    expect(res.body).to.be.an('object')
                    expect(res.body.kobold_id).to.eql(testKobolds[0].kobold_id)
                    expect(res.body.user_id).to.eql(testKobolds[0].user_id)
                    expect(res.body.kobold_level).to.eql(testKobolds[0].kobold_level)
                    expect(res.body.kobold_xp).to.eql(testKobolds[0].kobold_xp)
                    expect(res.body.kobold_unspent_points).to.eql(testKobolds[0].kobold_unspent_points)
                })
        })

        it('PATCH updates kobolds stats with provided kobold id', () => {
            const newKoboldStats = {
                kobold_unspent_points: 3,
                kobold_muscle: 4,
                kobold_fitness: 2,
                kobold_eloquence: 1,
                kobold_intellect: 9,
                kobold_mana: 10
            }

            return supertest(app)
                .patch('/api/kobold/1')
                .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                .send(newKoboldStats)
                .expect(204)
                .then(() => {
                    return supertest(app)
                        .get('/api/kobold')
                        .set('Authorization', helpers.makeAuthHeader(testUsers[0]))
                        .expect(200)
                        .expect(res => {
                            expect(res.body.kobold_unspent_points).to.eql(3)
                            expect(res.body.kobold_muscle).to.eql(4)
                            expect(res.body.kobold_fitness).to.eql(2)
                            expect(res.body.kobold_eloquence).to.eql(1)
                            expect(res.body.kobold_intellect).to.eql(9)
                            expect(res.body.kobold_mana).to.eql(10)
                        })
                })
        })
    })
})