const config = require('../config')

const KoboldsService = {
    getKoboldWithUserId(db, user_id) {
        return db('kobolds')
            .where({user_id})
            .first()
    }
}

module.exports = KoboldsService