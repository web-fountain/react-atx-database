SET search_path TO auth;


/*
 * CREATE TABLE magic_link
 */
CREATE TABLE IF NOT EXISTS  auth.magic_link (
  token                 UUID NOT NULL DEFAULT uuid_generate_v4(),
  expires_at            TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP + INTERVAL '8 minutes',
  is_used               BOOLEAN NOT NULL DEFAULT FALSE,

  magic_link_type       TEXT NOT NULL,
  email                 auth.email NOT NULL,

  created_at            TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT magic_link_token_pkey
    PRIMARY KEY (token),

  CONSTRAINT magic_link_type_fkey
    FOREIGN KEY (magic_link_type)
    REFERENCES auth.magic_link_type (name)
);


-- INDICES --
CREATE INDEX IF NOT EXISTS magic_link_token_idx
  ON auth.magic_link
  USING btree (token);

CREATE INDEX IF NOT EXISTS magic_link_email_idx
  ON auth.magic_link
  USING btree (email);

CREATE INDEX IF NOT EXISTS magic_link_type_idx
  ON auth.magic_link
  USING btree (magic_link_type);


-- TRIGGERS --
CREATE TRIGGER tr_magic_link_updated_at_update
  BEFORE UPDATE
    ON auth.magic_link
  FOR EACH ROW
    EXECUTE PROCEDURE auth.moddatetime(updated_at);


-- GRANTS --
GRANT ALL ON TABLE auth.magic_link TO dev;
