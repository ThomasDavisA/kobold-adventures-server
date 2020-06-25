const config = require('../config')

const KoboldsService = {
    getKoboldWithUserId(db, user_id) {
        return db('kobolds')
            .where({ user_id })
            .first()
    },
    getKoboldWithKoboldId(db, kobold_id) {
        return db('kobolds')
            .where({ kobold_id })
            .first()
    },
    updateKoboldXpWithKoboldId(db, kobold_id, xp) {
        return db('kobolds')
            .where({ kobold_id })
            .update({ kobold_xp: xp })
    },
    updateKoboldLevelWithKoboldId(db, kobold_id, kobold_level) {
        return db('kobolds')
            .where({ kobold_id })
            .update({ kobold_level })
    },
    updateKoboldCurrencyWithKoboldId(db, kobold_id, nickels, scrap, influence) {
        return db('kobolds')
            .where({ kobold_id })
            .update({
                currency_wood_nickels: nickels,
                currency_equipment_scraps: scrap,
                currency_dragon_influence: influence
            })
    },
    updateKoboldStatsWithKoboldId(db, kobold_id, kobold_muscle, kobold_fitness, kobold_eloquence, kobold_intellect, kobold_mana) {
        return db('kobolds')
            .where({ kobold_id })
            .update({
                kobold_muscle,
                kobold_fitness,
                kobold_eloquence,
                kobold_intellect,
                kobold_mana
            })
    },
    updateAdventureWithKoboldId(db, kobold_id, xp, nickels, scrap, influence) {
        return db('kobolds')
            .where({ kobold_id })
            .update({
                adventure_xp_tally: xp,
                adventure_nickel_tally: nickels,
                adventure_scrap_tally: scrap,
                adventure_influence_tally: influence
            })
    },
    clearAdventureWithKoboldId(db, kobold_id) {
        return db('kobolds')
            .where({ kobold_id })
            .update({
                adventure_xp_tally: null,
                adventure_nickel_tally: null,
                adventure_scrap_tally: null,
                adventure_influence_tally: null
            })
    }
}

module.exports = KoboldsService