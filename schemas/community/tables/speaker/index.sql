SET search_path TO community;


/*
 * CREATE TABLE speaker
 */
CREATE TABLE IF NOT EXISTS community.speaker (
  speaker_id                  UUID NOT NULL DEFAULT uuid_generate_v4(),
  email                       community.email NOT NULL,

  first_name                  TEXT NOT NULL,
  last_name                   TEXT NOT NULL,
  job_title                   TEXT,
  company_name                TEXT,

  presentation_title          TEXT NOT NULL,
  presentation_summary        TEXT NOT NULL,

  status                      TEXT NOT NULL DEFAULT 'pending',

  created_at                  TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at                  TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT speaker_id_pkey
    PRIMARY KEY (speaker_id),

  CONSTRAINT speaker_first_name_check
    CHECK (
      LENGTH(first_name) <= 64
    ),
  CONSTRAINT speaker_last_name_check
    CHECK (
      LENGTH(last_name) <= 64
    ),
  CONSTRAINT speaker_job_title_check
    CHECK (
      LENGTH(job_title) <= 64
    ),
  CONSTRAINT speaker_company_name_check
    CHECK (
      LENGTH(company_name) <= 64
    ),
  CONSTRAINT speaker_presentation_title_check
    CHECK (
      LENGTH(presentation_title) <= 128
    ),
  CONSTRAINT speaker_presentation_summary_check
    CHECK (
      LENGTH(presentation_summary) <= 4096
    ),

  CONSTRAINT speaker_status_fkey
    FOREIGN KEY (status)
    REFERENCES community.speaker_sponsor_status (name)
);


-- INDICES --
CREATE INDEX IF NOT EXISTS speaker_speaker_id_idx
  ON community.speaker
  USING btree (speaker_id);

CREATE INDEX IF NOT EXISTS speaker_email_idx
  ON community.speaker
  USING btree (email);

CREATE INDEX IF NOT EXISTS speaker_first_name_idx
  ON community.speaker
  USING btree (first_name);

CREATE INDEX IF NOT EXISTS speaker_last_name_idx
  ON community.speaker
  USING btree (last_name);

CREATE INDEX IF NOT EXISTS speaker_job_title_idx
  ON community.speaker
  USING btree (job_title);

CREATE INDEX IF NOT EXISTS speaker_company_name_idx
  ON community.speaker
  USING btree (company_name);


-- TRIGGERS --
CREATE TRIGGER tr_speaker_updated_at_update
  BEFORE UPDATE
    ON community.speaker
  FOR EACH ROW
    EXECUTE PROCEDURE community.moddatetime(updated_at);


-- GRANTS --
GRANT ALL ON TABLE community.member TO dev;
