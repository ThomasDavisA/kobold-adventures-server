ALTER TABLE resolutions
    DROP COLUMN IF EXISTS encounter_id;

DROP TABLE IF EXISTS resolutions;

ALTER TABLE encounters
    DROP COLUMN IF EXISTS location_id;

DROP TABLE IF EXISTS encounters;

DROP TABLE IF EXISTS locations;

ALTER TABLE kobolds
    DROP COLUMN IF EXISTS user_id;

DROP TABLE IF EXISTS kobolds;

DROP TABLE IF EXISTS users;