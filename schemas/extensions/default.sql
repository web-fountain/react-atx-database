CREATE EXTENSION IF NOT EXISTS citext SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS moddatetime SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS pgcrypto SCHEMA extensions;


-- make sure 'dev' can use everything in the extensions schema
GRANT USAGE
  ON SCHEMA extensions
  TO dev;
GRANT EXECUTE
  ON ALL FUNCTIONS
  IN SCHEMA extensions
  TO dev;

-- include future extensions
ALTER DEFAULT PRIVILEGES
  IN SCHEMA extensions
  GRANT USAGE
    ON TYPES
    TO dev;

ALTER DEFAULT PRIVILEGES
  IN SCHEMA extensions
  GRANT EXECUTE
    ON FUNCTIONS
    TO dev;


-- moddatetime
-- https://www.postgresql.org/docs/13/contrib-spi.html#id-1.11.7.45.8
