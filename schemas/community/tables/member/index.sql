SET search_path TO extensions, community;


/*
 * CREATE TABLE member
 */
CREATE TABLE IF NOT EXISTS community.member (
  email             community.email NOT NULL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT member_email_pkey
    PRIMARY KEY (email)
);


-- INDICES --
CREATE INDEX IF NOT EXISTS member_email_idx
  ON community.member
  USING btree (email);


-- GRANTS --
-- GRANT ALL ON TABLE community.member TO dev;
