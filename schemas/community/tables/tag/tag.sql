SET search_path TO community;


/*
 * CREATE TABLE tag
 * https://meta.stackoverflow.com/questions/272625/what-is-the-length-limit-on-tag-names
 */
CREATE TABLE IF NOT EXISTS community.tag (
  tag_id      UUID NOT NULL DEFAULT uuid_generate_v4(),
  name        TEXT NOT NULL,

  created_at         TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT tag_tag_id_pkey
    PRIMARY KEY (tag_id),
  CONSTRAINT tag_name_check
    CHECK (
      LENGTH(name) <= 35
    )
);

CREATE INDEX IF NOT EXISTS tag_tag_id_idx
  ON community.tag
  USING btree (tag_id);
CREATE INDEX IF NOT EXISTS tag_name_idx
  ON community.tag
  USING btree (name);


-- TRIGGERS --
CREATE TRIGGER tr_tag_update_updated_at
  BEFORE UPDATE
    ON community.tag
  FOR EACH ROW
    EXECUTE PROCEDURE community.moddatetime(updated_at);

GRANT ALL ON TABLE community.member TO dev;
