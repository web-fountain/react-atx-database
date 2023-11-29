SET search_path TO community, auth;


/*
 * CREATE TABLE verification_token
 */
CREATE TABLE IF NOT EXISTS  auth.verification_token (
  identifier        TEXT,
  token             TEXT,
  expires           TIMESTAMPTZ NOT NULL,


  CONSTRAINT verification_token_token_pkey
    PRIMARY KEY (token),

  CONSTRAINT verification_token_token_key
    UNIQUE (token),

  CONSTRAINT verification_token_token_identifier_key
    UNIQUE (token, identifier)
);

CREATE INDEX IF NOT EXISTS verification_token_token_idx
  ON auth.verification_token
  USING btree (token);
CREATE INDEX IF NOT EXISTS verification_token_token_identifier_idx
  ON auth.verification_token
  USING btree (token, identifier);

GRANT ALL ON TABLE auth.verification_token TO dev;
