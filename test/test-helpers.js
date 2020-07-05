const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')

function makeUsersArray() {
    return [
        {
            user_id: 1,
            username: 'test-user-1',
            password: 'password',
            date_created: '2029-01-22T16:28:32.615Z',
        },
        {
            user_id: 2,
            username: 'test-user-2',
            password: 'password',
            date_created: '2029-01-22T16:28:32.615Z',
        },
        {
            user_id: 3,
            username: 'test-user-3',
            password: 'password',
            date_created: '2029-01-22T16:28:32.615Z',
        }
    ]
}

function makeKoboldsArray() {
    return [
        {
            kobold_id: 1,
            user_id: 1,
            kobold_name: 'test kobold',
            kobold_level: 2,
            kobold_xp: 100,
            kobold_unspent_points: 3,
            kobold_muscle: 1,
            kobold_fitness: 1,
            kobold_eloquence: 1,
            kobold_mana: 1,
            kobold_intellect: 1,
            currency_wood_nickels: 100,
            currency_equipment_scraps: 5,
            currency_dragon_influence: 20,
            kobold_health: 100,
            kobold_energy: 100,
            kobold_max_energy: 100,
            kobold_max_health: 100,
            adventure_progress: 0
        },
        {
            kobold_id: 2,
            user_id: 2,
            kobold_name: 'test kobold 2',
            kobold_level: 3,
            kobold_xp: 200,
            kobold_unspent_points: 6,
            kobold_muscle: 2,
            kobold_fitness: 2,
            kobold_eloquence: 2,
            kobold_mana: 2,
            kobold_intellect: 2,
            currency_wood_nickels: 200,
            currency_equipment_scraps: 10,
            currency_dragon_influence: 30,
            kobold_health: 100,
            kobold_energy: 100,
            kobold_max_energy: 100,
            kobold_max_health: 100,
            adventure_progress: 0
        },
        {
            kobold_id: 3,
            user_id: 3,
            kobold_name: 'test kobold 3',
            kobold_level: 3,
            kobold_xp: 300,
            kobold_unspent_points: 9,
            kobold_muscle: 3,
            kobold_fitness: 3,
            kobold_eloquence: 3,
            kobold_mana: 3,
            kobold_intellect: 3,
            currency_wood_nickels: 300,
            currency_equipment_scraps: 20,
            currency_dragon_influence: 60,
            kobold_health: 100,
            kobold_energy: 100,
            kobold_max_energy: 100,
            kobold_max_health: 100,
            adventure_progress: 0
        },
    ]
}

function makeLocationsArray() {
    return [
        {
            location_id: 1,
            location_name: 'test-location 1',
            location_description: 'test-desc 1',
            location_level: 1
        },
        {
            location_id: 2,
            location_name: 'test-location 2',
            location_description: 'test-desc 2',
            location_level: 3
        },
    ]
}

function makeEncountersArray() {
    return [
        {
            encounter_id: 1,
            location_id: 1,
            encounter_name: 'test encounter 1',
            encounter_text: 'text encounter text 1',
            encounter_level: 1,
            encounter_base_difficulty: 1,
            encounter_bonus_difficulty: 1,
            encounter_base_reward: 1,
            encounter_bonus_reward: 1
        },
        {
            encounter_id: 2,
            location_id: 1,
            encounter_name: 'test encounter 1',
            encounter_text: 'text encounter text 1',
            encounter_level: 1,
            encounter_base_difficulty: 1,
            encounter_bonus_difficulty: 1,
            encounter_base_reward: 1,
            encounter_bonus_reward: 1
        },
        {
            encounter_id: 3,
            location_id: 2,
            encounter_name: 'test encounter 1',
            encounter_text: 'text encounter text 1',
            encounter_level: 1,
            encounter_base_difficulty: 1,
            encounter_bonus_difficulty: 1,
            encounter_base_reward: 1,
            encounter_bonus_reward: 1
        },
        {
            encounter_id: 4,
            location_id: 2,
            encounter_name: 'test encounter 1',
            encounter_text: 'text encounter text 1',
            encounter_level: 1,
            encounter_base_difficulty: 1,
            encounter_bonus_difficulty: 1,
            encounter_base_reward: 1,
            encounter_bonus_reward: 1
        }
    ]
}

function makeResolutionsArray() {
    let resolutions = []
    let key = 0
    for (i = 0; i < 4; i++) {
        for (j = 0; j < 5; j++) {
            key++
            resolutions.push(
                {
                    id: key,
                    encounter_id: i + 1,
                    resolution_name: `test resolution ${j + 1}`,
                    resolution_action: `test action ${j + 1}`,
                    resolution_stat: 'muscle',
                    resolution_success: `test success text ${j + 1}`,
                    resolution_fail: `test fail text ${j + 1}`
                }
            )
        }
    }
    return resolutions
}

function cleanTables(db) {
    return db.raw(
        `TRUNCATE
        users,
        kobolds,
        locations,
        encounters,
        resolutions
        RESTART IDENTITY CASCADE`
    )
}

function seedUsers(db, users) {
    const preppedUsers = users.map(user => ({
        ...user,
        password: bcrypt.hashSync(user.password, 1)
    }))
    return db.into('users').insert(preppedUsers)
        .then(() =>
            // update the auto sequence to stay in sync
            db.raw(
                `SELECT setval('users_user_id_seq', ?)`,
                [users[users.length - 1].user_id],
            )
        )
}

function seedKobolds(db, kobolds, users) {
    return db.transaction(async trx => {
        await seedUsers(trx, users)
        await trx.into('kobolds').insert(kobolds)
        await trx.raw(
            `SELECT setval('kobolds_kobold_id_seq', ?)`,
            [kobolds[kobolds.length - 1].kobold_id],
        )
    })
}

function seedLocations(db, locations) {
    return db.into('locations').insert(locations)
    .then(() =>
        db.raw(
            `SELECT setval('locations_location_id_seq', ?)`,
            [locations[locations.length - 1].location_id],
        )
    )
}

function seedEncounters(db, encounters) {
    return db.into('encounters').insert(encounters)
    .then(() =>
        db.raw(
            `SELECT setval('encounters_encounter_id_seq', ?)`,
            [encounters[encounters.length - 1].encounter_id],
        )
    )
}

function seedResolutions(db, locs, encs, res) {
    return db.transaction(async trx => {
        await seedLocations(trx, locs)
        await seedEncounters(trx, encs)
        await trx.into('resolutions').insert(res)
        await trx.raw(
            `SELECT setval('resolutions_id_seq', ?)`,
            [res[res.length - 1].id],
        )
    })
}

function makeAuthHeader(user, secret = process.env.JWT_SECRET) {
    const token = jwt.sign({ user_id: user.id }, secret, {
        subject: user.username,
        algorithm: 'HS256'
    })
    return `Bearer ${token}`
}

module.exports = {
    makeUsersArray,
    makeKoboldsArray,
    makeLocationsArray,
    makeEncountersArray,
    makeResolutionsArray,
    seedUsers,
    seedKobolds,
    seedResolutions,
    seedLocations,
    cleanTables,
    makeAuthHeader
}