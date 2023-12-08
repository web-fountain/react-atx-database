SET search_path TO community;


/*
 * CREATE TABLE membership_type
 */
CREATE TABLE IF NOT EXISTS community.membership_type (
  name              TEXT NOT NULL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT membership_type_name_pkey
    PRIMARY KEY (name)
);


-- INDICES --
CREATE INDEX IF NOT EXISTS membership_type_name_idx
  ON community.membership_type
  USING btree (name);


-- GRANTS --
GRANT ALL ON TABLE community.membership_type TO dev;

/*
  bronze    === member
  silver    === member_with_profile
  gold      === speaker
  platinum  === sponsor
  diamond   === speaker + sponsor
*/
