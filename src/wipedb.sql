BEGIN;

-- Remove all data from the database
DROP SCHEMA extensions, auth, community CASCADE;

COMMIT;
