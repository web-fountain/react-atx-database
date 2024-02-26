SET search_path TO auth;


CREATE OR REPLACE FUNCTION
  validate_magic_link_token(magic_link_token TEXT)
RETURNS TABLE (is_valid BOOLEAN) AS
  $$
    DECLARE
      token_record RECORD;

    BEGIN
      SELECT mlt.is_used, mlt.expires_at, m.email, m.is_verified INTO token_record
      FROM "auth".magic_link_token AS mlt
      JOIN "community".member AS m
        ON m.email = mlt.email
      WHERE mlt.token = magic_link_token;

      IF NOT FOUND
      THEN
        RETURN QUERY
          SELECT
            FALSE       AS is_valid;

      -- member is already verified
      ELSEIF token_record.is_verified = TRUE
      THEN
        RETURN QUERY
          SELECT
            TRUE        AS is_valid;

      -- magic_link_token is used or expired
      ELSEIF
        token_record.is_used = TRUE
          OR
        token_record.expires_at < NOW()
      THEN
        RETURN QUERY
          SELECT
            FALSE       AS is_valid;

      -- magic_link_token is valid so update the token and member
      ELSE
        UPDATE "auth".magic_link_token AS mlt
        SET is_used = TRUE
        WHERE mlt.token = magic_link_token;

        UPDATE "community".member AS m
        SET is_verified = TRUE
        WHERE m.email = token_record.email;

        RETURN QUERY
          SELECT
            TRUE        AS is_valid;
      END IF;
    END;
  $$
LANGUAGE PLPGSQL;


-- SELECT is_valid FROM validate_magic_link_token(<token>);
