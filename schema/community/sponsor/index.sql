SET search_path TO community;


/*
 * CREATE TABLE sponsor
 */
CREATE TABLE IF NOT EXISTS community.sponsor (
  sponsor_id          UUID NOT NULL DEFAULT uuid_generate_v4(),
  account_id          UUID NOT NULL,

  display_name        TEXT,
  job_title           TEXT,
  company_name        TEXT,

  status              TEXT NOT NULL DEFAULT 'pending',

  created_at          TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT sponsoer_id_pkey
    PRIMARY KEY (sponsor_id),

  CONSTRAINT sponsor_display_name_check
    CHECK (
      LENGTH(display_name) <= 64
    ),
  CONSTRAINT sponsor_job_title_check
    CHECK (
      LENGTH(job_title) <= 64
    ),
  CONSTRAINT sponsor_company_name_check
    CHECK (
      LENGTH(company_name) <= 64
    ),

  CONSTRAINT sponsor_account_id_fkey
    FOREIGN KEY (account_id)
    REFERENCES community.account (account_id),
  CONSTRAINT sponsor_status_fkey
    FOREIGN KEY (status)
    REFERENCES community.speaker_sponsor_status (name)
);
CREATE INDEX IF NOT EXISTS sponsor_sponsor_id_idx
  ON community.sponsor
  USING btree (sponsor_id);
CREATE INDEX IF NOT EXISTS sponsor_display_name_idx
  ON community.sponsor
  USING btree (display_name);
CREATE INDEX IF NOT EXISTS sponsor_company_name_idx
  ON community.sponsor
  USING btree (company_name);


-- TRIGGERS --
CREATE TRIGGER tr_sponsor_updated_at_update
  BEFORE UPDATE
    ON community.sponsor
  FOR EACH ROW
    EXECUTE PROCEDURE community.moddatetime(updated_at);
