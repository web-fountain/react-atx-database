SET search_path TO extensions, auth;


/*
 * DOMAINS
 * https://dba.stackexchange.com/questions/68266/what-is-the-best-way-to-store-an-email-address-in-postgresql
 * https://stackoverflow.com/questions/386294/what-is-the-maximum-length-of-a-valid-email-address
 */
CREATE DOMAIN auth.email AS citext
  CHECK (
    LENGTH(value) <= 254
    AND
    LENGTH(value) >= 6
    AND
    value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'
  );
