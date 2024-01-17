SET search_path TO community;


/*
 * CREATE JUNCTION TABLE news_item_tag
 */
CREATE TABLE IF NOT EXISTS community.news_item_tag (
  news_item_tag_id    UUID NOT NULL DEFAULT uuid_generate_v4(),

  news_item_id        UUID NOT NULL,
  tag_id              UUID NOT NULL,

  created_at          TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT news_item_tag_news_item_id_tag_id_pkey
    PRIMARY KEY (news_item_id, tag_id),
  CONSTRAINT news_item_tag_news_item_id_fkey
    FOREIGN KEY (news_item_id)
    REFERENCES community.news_item (news_item_id),
  CONSTRAINT news_item_tag_tag_id_fkey
    FOREIGN KEY (tag_id)
    REFERENCES community.news_tag (tag_id)

);
CREATE INDEX IF NOT EXISTS news_item_tag_news_item_tag_id_idx
  ON community.news_item_tag
  USING btree (news_item_tag_id);
CREATE INDEX IF NOT EXISTS news_item_tag_news_item_id_idx
  ON community.news_item_tag
  USING btree (news_item_id);
CREATE INDEX IF NOT EXISTS news_item_tag_tag_id_idx
  ON community.news_item_tag
  USING btree (tag_id);


-- TRIGGERS --
CREATE TRIGGER tr_news_item_tag_update_updated_at
  BEFORE UPDATE
    ON community.news_item_tag
  FOR EACH ROW
    EXECUTE PROCEDURE extensions.moddatetime(updated_at);
