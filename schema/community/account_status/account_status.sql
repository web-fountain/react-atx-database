SET search_path TO community;


/*
 * CREATE TABLE account_status
 * need to set Write/Grant Permissions
 * --see seed/account_status.sql--
 */
CREATE TABLE IF NOT EXISTS community.account_status (
  name          TEXT NOT NULL UNIQUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,



  CONSTRAINT account_status_name_pkey
    PRIMARY KEY (name)
);

CREATE INDEX IF NOT EXISTS account_status_name_idx
  ON community.account_status
  USING btree (name);
