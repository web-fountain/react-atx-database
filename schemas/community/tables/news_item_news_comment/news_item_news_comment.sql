SET search_path TO community;


/*
 * CREATE JUNCTION TABLE news_item_news_comment
 */
CREATE TABLE IF NOT EXISTS community.news_item_news_comment (
  news_item_news_comment_id    UUID NOT NULL DEFAULT uuid_generate_v4(),

  news_item_id                 UUID NOT NULL,
  news_comment_id              UUID NOT NULL,
  depth                        INT NOT NULL DEFAULT 0,

  created_at                   TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at                   TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT news_item_news_comment_news_item_id_news_comment_id_pkey
    PRIMARY KEY (news_item_id, news_comment_id),
  CONSTRAINT news_item_news_comment_news_item_id_fkey
    FOREIGN KEY (news_item_id)
    REFERENCES community.news_item (news_item_id),
  CONSTRAINT news_item_news_comment_news_comment_id_fkey
    FOREIGN KEY (news_comment_id)
    REFERENCES community.news_comment (news_comment_id)

);
CREATE INDEX IF NOT EXISTS news_item_news_comment_news_item_news_comment_id_idx
  ON community.news_item_news_comment
  USING btree (news_item_news_comment_id);
CREATE INDEX IF NOT EXISTS news_item_news_comment_news_item_id_idx
  ON community.news_item_news_comment
  USING btree (news_item_id);
CREATE INDEX IF NOT EXISTS news_item_news_comment_news_comment_id_idx
  ON community.news_item_news_comment
  USING btree (news_comment_id);


-- TRIGGERS --
CREATE TRIGGER tr_news_item_news_comment_update_updated_at
  BEFORE UPDATE
    ON community.news_item_news_comment
  FOR EACH ROW
    EXECUTE PROCEDURE extensions.moddatetime(updated_at);
