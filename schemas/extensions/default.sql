CREATE EXTENSION IF NOT EXISTS citext SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS moddatetime SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" SCHEMA extensions;


-- make sure everybody can use everything in the extensions schema
GRANT USAGE
  ON SCHEMA extensions
  TO reactatx;
GRANT EXECUTE
  ON ALL FUNCTIONS
  IN SCHEMA extensions
  TO reactatx;

-- include future extensions
ALTER DEFAULT PRIVILEGES
  IN SCHEMA extensions
  GRANT EXECUTE
    ON FUNCTIONS
    TO reactatx;

ALTER DEFAULT PRIVILEGES
  IN SCHEMA extensions
  GRANT USAGE
    ON TYPES
    TO reactatx;


-- moddatetime
-- https://www.postgresql.org/docs/13/contrib-spi.html#id-1.11.7.45.8
