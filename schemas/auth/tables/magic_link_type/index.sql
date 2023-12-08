SET search_path TO auth;


/*
 * CREATE TABLE magic_link_type
 */
CREATE TABLE IF NOT EXISTS auth.magic_link_type (
  name              TEXT NOT NULL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT magic_link_type_name_pkey
    PRIMARY KEY (name)
);


-- INDICES --
CREATE INDEX IF NOT EXISTS magic_link_type_name_idx
  ON auth.magic_link_type
  USING btree (name);


-- GRANTS --
-- GRANT ALL ON TABLE auth.magic_link_type TO dev;


/*
  join, speaker, sponsor
*/
