const config = require('../config')

const LocationsService = {
    getLocations(db) {
        return db('locations')
            .select('*')
    },
    getLocationsByLevel(db, kobold_level) {
        return db('locations')
            .where(kobold_level, '>=',  'location_level')
            .first()
    },
}

module.exports = LocationsService