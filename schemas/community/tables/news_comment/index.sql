SET search_path TO community;


/*
 * CREATE TABLE news_comment
 */
CREATE TABLE IF NOT EXISTS community.news_comment (
  news_comment_id    UUID NOT NULL DEFAULT uuid_generate_v4(),

  news_item_id       UUID NOT NULL,
  account_id         UUID NOT NULL,

  content            TEXT NOT NULL,

  created_at         TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT news_comment_news_comment_id_pkey
    PRIMARY KEY (news_comment_id),

  CONSTRAINT comment_content_check
    CHECK (
      LENGTH(content) <= 4096
    ),

  CONSTRAINT news_comment_news_item_id_fkey
    FOREIGN KEY (news_item_id)
    REFERENCES community.news_item (news_item_id),
  CONSTRAINT news_comment_account_id_fkey
    FOREIGN KEY (account_id)
    REFERENCES community.account (account_id)
);
CREATE INDEX IF NOT EXISTS news_comment_news_comment_id_idx
  ON community.news_comment
  USING btree (news_comment_id);
CREATE INDEX IF NOT EXISTS news_comment_news_item_id_idx
  ON community.news_comment
  USING btree (news_item_id);
CREATE INDEX IF NOT EXISTS news_comment_account_id_idx
  ON community.news_comment
  USING btree (account_id);


-- TRIGGERS --
CREATE TRIGGER tr_news_comment_update_updated_at
  BEFORE UPDATE
    ON community.news_comment
  FOR EACH ROW
    EXECUTE PROCEDURE extensions.moddatetime(updated_at);
