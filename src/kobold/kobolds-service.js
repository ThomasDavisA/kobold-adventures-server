const config = require('../config')

const KoboldsService = {
    getKoboldWithUserId(db, user_id) {
        return db('kobolds')
            .where({ user_id })
            .first()
    },
    getKoboldWithUsername(db, username){
        return db('users')
            .where({username})
            .first()
            .then(user => {
                return db('kobolds')
                    .where({user_id: user.user_id})
                    .first()
            })
    },
    getKoboldWithKoboldId(db, kobold_id) {
        return db('kobolds')
            .where({ kobold_id })
            .first()
    },
    createKoboldWithUser(db, user) {
        return db('kobolds')
            .insert({
                user_id: user.user_id,
                kobold_name: user.username
            })
            .returning('*')
    },
    updateKoboldXpWithKoboldId(db, kobold_id) {
        return db('kobolds')
            .select('kobold_xp', 'adventure_xp_tally')
            .where({ kobold_id })
            .then(results => {
                return db('kobolds')
                    .where({ kobold_id })
                    .update({
                        kobold_xp: results[0].kobold_xp + results[0].adventure_xp_tally
                    }, ['kobold_xp'])
            })

    },
    updateKoboldLevelWithKoboldId(db, kobold_id) {
        return db('kobolds')
            .where({ kobold_id })
            .select('kobold_level', 'kobold_unspent_points')
            .then(results => {
                return db('kobolds')
                    .where(({ kobold_id }))
                    .update({
                        kobold_level: results[0].kobold_level + 1,
                        kobold_unspent_points: results[0].kobold_unspent_points + 3
                    })
            })
    },
    updateKoboldCurrencyWithKoboldId(db, kobold_id) {
        return db('kobolds')
            .select('currency_wood_nickels', 'adventure_nickel_tally',
                'currency_equipment_scraps', 'adventure_scrap_tally',
                'currency_dragon_influence', 'adventure_influence_tally')
            .where({ kobold_id })
            .then(results => {
                return db('kobolds')
                    .where({ kobold_id })
                    .update({
                        currency_wood_nickels: results[0].currency_wood_nickels + results[0].adventure_nickel_tally,
                        currency_equipment_scraps: results[0].currency_equipment_scraps + results[0].adventure_scrap_tally,
                        currency_dragon_influence: results[0].currency_dragon_influence + results[0].adventure_influence_tally
                    })
            })

    },
    updateKoboldStatsWithKoboldId(db, kobold_id, koboldStats) {
        console.log(koboldStats, kobold_id)
        return db('kobolds')
            .where({ kobold_id })
            .update({
                kobold_unspent_points: koboldStats.kobold_unspent_points,
                kobold_muscle: koboldStats.kobold_muscle,
                kobold_fitness: koboldStats.kobold_fitness,
                kobold_eloquence: koboldStats.kobold_eloquence,
                kobold_intellect: koboldStats.kobold_intellect,
                kobold_mana: koboldStats.kobold_mana
            })
    },
    updateAdventureWithKoboldId(db, kobold_id, xp, nickels, scrap, influence, progress) {
        return db('kobolds')
            .where({ kobold_id })
            .update({
                adventure_xp_tally: xp,
                adventure_nickel_tally: nickels,
                adventure_scrap_tally: scrap,
                adventure_influence_tally: influence,
                adventure_progress: progress
            })
    },
    clearAdventureWithKoboldId(db, kobold_id) {
        return db('kobolds')
            .where({ kobold_id })
            .update({
                adventure_xp_tally: 0,
                adventure_nickel_tally: 0,
                adventure_scrap_tally: 0,
                adventure_influence_tally: 0
            })
    },
    clearAdventureProgressWithKoboldId(db, kobold_id) {
        return db('kobolds')
            .where({ kobold_id })
            .update({
                adventure_progress: 0
            })
    }
}

module.exports = KoboldsService