SET search_path TO extensions, community;


/*
 * CREATE TABLE sponsor_status
 */
CREATE TABLE IF NOT EXISTS community.sponsor_status (
  name          TEXT NOT NULL,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT sponsor_status_name_pkey
    PRIMARY KEY (name),

  CONSTRAINT sponsor_status_name_key
    UNIQUE (name)
);


-- INDICES --
CREATE INDEX IF NOT EXISTS sponsor_status_name_idx
  ON community.sponsor_status
  USING btree (name);


-- GRANTS --
-- GRANT ALL ON TABLE community.sponsor_status TO dev;


/*
  canceled, confirmed, pending
*/
