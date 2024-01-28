SET search_path TO auth;


CREATE OR REPLACE FUNCTION
  create_magic_link_join_token(email TEXT)
RETURNS TABLE (token TEXT, expires_at TIMESTAMPTZ) AS
  $$
    BEGIN
      RETURN QUERY
        INSERT INTO "auth".magic_link_token AS mlt (email, magic_link_type) VALUES (email, 'join')
        RETURNING
          mlt.token_id::TEXT                AS token,
          mlt.expires_at::TIMESTAMPTZ       AS expires_at;
    END;
  $$
LANGUAGE PLPGSQL;


-- SELECT token, expires_at FROM create_magic_link_join_token('email@example.com')
