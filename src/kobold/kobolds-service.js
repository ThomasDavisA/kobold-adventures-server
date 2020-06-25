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
    updateKoboldCurrencyWithKoboldId(db, kobold_id, nickels, scrap, influence) {
        return db('kobolds')
            .where({ kobold_id })
            .update({ 
                currency_wood_nickels: nickels,
                currency_equipment_scraps: scrap,
                currency_dragon_influence: influence
            })
    }
}

module.exports = KoboldsService