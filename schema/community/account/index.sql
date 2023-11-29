SET search_path TO community;


/*
 * CREATE TABLE account
 */
CREATE TABLE IF NOT EXISTS community.account (
  account_id             UUID NOT NULL DEFAULT uuid_generate_v4(),

  email                  community.email,
  email_verified         TIMESTAMPTZ,

  status                 TEXT NOT NULL DEFAULT 'pending',

  created_at             TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at             TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT account_id_pkey
    PRIMARY KEY (account_id),

  CONSTRAINT account_email_key
    UNIQUE (email),

  CONSTRAINT account_status_type_fkey
    FOREIGN KEY (status)
    REFERENCES community.account_status (name)
);

CREATE INDEX IF NOT EXISTS account_account_id_idx
  ON community.account
  USING btree (account_id);
CREATE INDEX IF NOT EXISTS account_email_idx
  ON community.account
  USING btree (email);


-- TRIGGERS --
CREATE TRIGGER tr_account_updated_at_update
  BEFORE UPDATE
    ON community.account
  FOR EACH ROW
    EXECUTE PROCEDURE community.moddatetime(updated_at);

GRANT ALL ON TABLE community.account TO dev;
