SET search_path TO extensions, community;


/*
 * CREATE TABLE sponsor
 */
CREATE TABLE IF NOT EXISTS community.sponsor (
  sponsor_id          UUID NOT NULL DEFAULT uuid_generate_v4(),
  email               community.email NOT NULL,

  first_name          TEXT NOT NULL,
  last_name           TEXT NOT NULL,
  job_title           TEXT,
  company_name        TEXT,

  status              TEXT NOT NULL DEFAULT 'pending',

  created_at          TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT sponsor_id_pkey
    PRIMARY KEY (sponsor_id),

  CONSTRAINT sponsor_first_name_check
    CHECK (
      LENGTH(first_name) <= 64
    ),
  CONSTRAINT sponsor_last_name_check
    CHECK (
      LENGTH(last_name) <= 64
    ),
  CONSTRAINT sponsor_job_title_check
    CHECK (
      LENGTH(job_title) <= 64
    ),
  CONSTRAINT sponsor_company_name_check
    CHECK (
      LENGTH(company_name) <= 64
    ),

  CONSTRAINT sponsor_status_fkey
    FOREIGN KEY (status)
    REFERENCES community.sponsor_status (name)
);


-- INDICES --
CREATE INDEX IF NOT EXISTS sponsor_sponsor_id_idx
  ON community.sponsor
  USING btree (sponsor_id);

CREATE INDEX IF NOT EXISTS sponsor_email_idx
  ON community.sponsor
  USING btree (email);

CREATE INDEX IF NOT EXISTS sponsor_first_name_idx
  ON community.sponsor
  USING btree (first_name);

CREATE INDEX IF NOT EXISTS sponsor_last_name_idx
  ON community.sponsor
  USING btree (last_name);

CREATE INDEX IF NOT EXISTS sponsor_company_name_idx
  ON community.sponsor
  USING btree (company_name);


-- TRIGGERS --
CREATE TRIGGER tr_sponsor_updated_at_update
  BEFORE UPDATE
    ON community.sponsor
  FOR EACH ROW
    EXECUTE PROCEDURE extensions.moddatetime(updated_at);


-- GRANTS --
-- GRANT ALL ON TABLE community.member TO dev;
