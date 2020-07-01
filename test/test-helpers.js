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
            kobold_max_health: 100
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
            kobold_max_health: 100
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
            kobold_max_health: 100
        },
        {
            kobold_id: 4,
            user_id: 4,
            kobold_name: 'test kobold 4',
            kobold_level: 4,
            kobold_xp: 600,
            kobold_unspent_points: 33,
            kobold_muscle: 5,
            kobold_fitness: 6,
            kobold_eloquence: 7,
            kobold_mana: 8,
            kobold_intellect: 10,
            currency_wood_nickels: 800,
            currency_equipment_scraps: 39,
            currency_dragon_influence: 190,
            kobold_health: 100,
            kobold_energy: 100,
            kobold_max_energy: 100,
            kobold_max_health: 100
        },
    ]
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