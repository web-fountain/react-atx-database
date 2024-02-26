SET search_path TO auth;


CREATE OR REPLACE FUNCTION
  create_magic_link_token(email TEXT, magic_link_type TEXT)
RETURNS TABLE (token TEXT, expires_at TIMESTAMPTZ) AS
  $$
    DECLARE
      token_record RECORD;

    BEGIN
      INSERT INTO "auth".magic_link_token AS mlt
        (email, magic_link_type)
      VALUES (email, magic_link_type)
      RETURNING * INTO token_record;

      RETURN QUERY
        SELECT
          token_record.token            AS token,
          token_record.expires_at       AS expires_at;
    END;
  $$
LANGUAGE PLPGSQL;


-- SELECT token, expires_at FROM create_magic_link_token('email@example.com', 'join')
-- magic_link_type = [join, speaker, sponsor]
