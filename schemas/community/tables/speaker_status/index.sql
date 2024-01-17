SET search_path TO extensions, community;


/*
 * CREATE TABLE speaker_status
 */
CREATE TABLE IF NOT EXISTS community.speaker_status (
  name          TEXT NOT NULL,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT speaker_status_name_pkey
    PRIMARY KEY (name),

  CONSTRAINT speaker_status_name_key
    UNIQUE (name)
);


-- INDICES --
CREATE INDEX IF NOT EXISTS speaker_status_name_idx
  ON community.speaker_status
  USING btree (name);


-- GRANTS --
-- GRANT ALL ON TABLE community.speaker_status TO dev;


/*
  canceled, confirmed, pending
*/
