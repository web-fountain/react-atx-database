CREATE SCHEMA IF NOT EXISTS extensions;
CREATE SCHEMA IF NOT EXISTS auth;
CREATE SCHEMA IF NOT EXISTS community;


-- SET the search_path for the database to ALL schemas
-- NOTE: ALTER ROLE to limit search_path
ALTER DATABASE reactatx SET search_path TO extensions, auth, community;


-- CREATE SCHEMA IF NOT EXISTS community
--   AUTHORIZATION "db_admin";
-- CREATE SCHEMA IF NOT EXISTS auth
--   AUTHORIZATION "db_admin";

-- GRANT CREATE
--   ON SCHEMA public
--   TO "db_admin";

-- GRANT ALL
--   ON SCHEMA community
--   TO "react-atx";
-- GRANT ALL
--   ON SCHEMA auth
--   TO "react-atx";
