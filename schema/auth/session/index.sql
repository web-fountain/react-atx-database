SET search_path TO auth;


/*
 * CREATE TABLE session
 */
CREATE TABLE IF NOT EXISTS  auth.session (
  session_id          UUID NOT NULL DEFAULT uuid_generate_v4(),
  expires_at          TIMESTAMPTZ NOT NULL,
  token               TEXT NOT NULL,
  member_id           UUID,


  CONSTRAINT session_id_pkey
    PRIMARY KEY (session_id),
  CONSTRAINT session_token_key
    UNIQUE (token),

  CONSTRAINT session_member_id_fkey
    FOREIGN KEY (member_id)
    REFERENCES  auth.member (member_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS session_session_id_idx
  ON auth.session
  USING btree (session_id);
CREATE INDEX IF NOT EXISTS session_token_idx
  ON auth.session
  USING btree (token);

GRANT ALL ON TABLE auth.session TO dev;
