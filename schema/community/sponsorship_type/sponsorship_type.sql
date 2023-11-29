SET search_path TO community;


/*
 * CREATE TABLE sponsorship_type
 * seed/sponsorship_type.sql
 */
CREATE TABLE IF NOT EXISTS community.sponsorship_type (
  name          TEXT NOT NULL,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


  CONSTRAINT sponsorship_type_name_pkey
    PRIMARY KEY (name),

  CONSTRAINT sponsorship_type_name_key
    UNIQUE (name)
);
