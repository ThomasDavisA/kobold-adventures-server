const config = require('../config')

const AdventuresService = {
    getEncounterByLocation(db, location_id) {
        return db('encounters')
            .where(location_id, 'location_id')
    },
    getResolutionsByEncounter(db, encounter_id) {
        return db('resolutions')
            .where(encounter_id, 'encounter_id')
    }
}

module.exports = LocationsService