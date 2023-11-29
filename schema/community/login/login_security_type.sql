SET search_path TO community;


/*
 * CREATE TABLE login_security_type
 * need to set Write/Grant Permissions
 */
CREATE TABLE IF NOT EXISTS community.login_security_type (
  name          TEXT NOT NULL,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

  --  see seed/login_security_type.sql

  CONSTRAINT login_security_type_name_pkey
    PRIMARY KEY (name)
);
