SET search_path TO community;


/*
 * CREATE TABLE login_security
 * need to set Write/Grant Permissions
 */
CREATE TABLE IF NOT EXISTS community.login_security (
  name          TEXT NOT NULL DEFAULT 'magiclink',
  password      TEXT,
  provider      TEXT,

  account_id    UUID UNIQUE,

  created_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

  --  see seed/login_security.sql

  CONSTRAINT login_security_name_pkey
    PRIMARY KEY (name, account_id),

  CONSTRAINT login_security_password_check
    CHECK (
      LENGTH(password) >= 8
        AND
      LENGTH(password) <= 128
    ),
  CONSTRAINT login_security_provider_check
    CHECK (
      provider IN ('github', 'gitlab', 'linkedin', 'twitter')
    ),

  CONSTRAINT login_security_account_id_fkey
    FOREIGN KEY (account_id)
	REFERENCES community.account (account_id)
);
CREATE INDEX IF NOT EXISTS login_security_name_idx
  ON community.login_security
  USING btree (name);
CREATE INDEX IF NOT EXISTS login_security_account_id_idx
  ON community.login_security
  USING btree (account_id);


-- TRIGGERS --
CREATE TRIGGER tr_login_security_updated_at_update
  BEFORE UPDATE
    ON community.login_security
  FOR EACH ROW
    EXECUTE PROCEDURE extensions.moddatetime(updated_at);
