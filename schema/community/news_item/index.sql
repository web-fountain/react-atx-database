SET search_path TO community;


/*
 * CREATE TABLE news_item
 */
CREATE TABLE IF NOT EXISTS community.news_item (
  news_item_id       UUID NOT NULL DEFAULT uuid_generate_v4(),
  title              TEXT NOT NULL,
  url                TEXT NOT NULL,

  account_id         UUID NOT NULL,

  up_vote_count      INTEGER DEFAULT 0,
  down_vote_count    INTEGER DEFAULT 0,

  created_at         TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT news_item_news_item_id_pkey
    PRIMARY KEY (news_item_id),

  CONSTRAINT news_item_news_item_id_key
    UNIQUE (news_item_id),
  CONSTRAINT news_item_account_id_key
    UNIQUE (account_id),

  CONSTRAINT news_item_title_check
    CHECK (
      LENGTH(title) <= 80
    ),
  CONSTRAINT news_item_url_check
    CHECK (
      LENGTH(url) <= 2048
    ),

  CONSTRAINT news_item_account_id_fkey
    FOREIGN KEY (account_id)
	REFERENCES community.account (account_id)
);
CREATE INDEX IF NOT EXISTS news_item_news_item_id_idx
  ON community.news_item
  USING btree (news_item_id);
CREATE INDEX IF NOT EXISTS news_item_title_idx
  ON community.news_item
  USING btree (title);
CREATE INDEX IF NOT EXISTS news_item_url_idx
  ON community.news_item
  USING btree (url);
CREATE INDEX IF NOT EXISTS news_item_account_id_idx
  ON community.news_item
  USING btree (account_id);


-- TRIGGERS --
CREATE TRIGGER tr_news_item_updated_at_update
  BEFORE UPDATE
    ON community.news_item
  FOR EACH ROW
    EXECUTE PROCEDURE community.moddatetime(updated_at);
