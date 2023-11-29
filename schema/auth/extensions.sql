SET search_path TO "auth";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "citext";
CREATE EXTENSION IF NOT EXISTS "moddatetime";


-- moddatetime
-- https://www.postgresql.org/docs/13/contrib-spi.html#id-1.11.7.45.8
