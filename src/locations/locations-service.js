const config = require('../config')

const LocationsService = {
    getLocationsByLevel(db, kobold_level) {
        return db('locations')
            .where(kobold_level, '>=',  'location_level')
            .first()
    }
}

module.exports = LocationsService