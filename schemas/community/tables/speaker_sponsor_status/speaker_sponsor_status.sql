SET search_path TO community;


/*
 * CREATE TABLE speaker_sponsor_status
 */
CREATE TABLE IF NOT EXISTS community.speaker_sponsor_status (
  name          TEXT NOT NULL,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT speaker_sponsor_status_name_pkey
    PRIMARY KEY (name)
);


-- INDICES --
CREATE INDEX IF NOT EXISTS speaker_sponsor_status_name_idx
  ON community.speaker_sponsor_status
  USING btree (name);


-- GRANTS --
GRANT ALL ON TABLE community.membership_type TO dev;


/*
  canceled, confirmed, pending
*/
