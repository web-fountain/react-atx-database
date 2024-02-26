SET search_path TO community, auth;


CREATE OR REPLACE FUNCTION
  join_member(join_email TEXT)
RETURNS TABLE (is_verified BOOLEAN, is_new_member BOOLEAN, token TEXT, expires_at TIMESTAMPTZ) AS
  $$
    DECLARE
      member_record RECORD;
      token_record RECORD;

    BEGIN
      SELECT mbr.email, mbr.is_verified INTO member_record
      FROM "community".member AS mbr
      WHERE mbr.email = join_email;

      IF NOT FOUND THEN
      -- create new member
        INSERT INTO "community".member (email) VALUES (join_email);
        SELECT * INTO token_record FROM create_magic_link_token(join_email, 'join');

        RETURN QUERY
          SELECT
            FALSE                         AS is_verified,
            TRUE                          AS is_new_member,
            token_record.token            AS token,
            token_record.expires_at       AS expires_at;

      ELSEIF member_record.is_verified = FALSE THEN
      -- email has not been verified so send a new token
        SELECT * INTO token_record FROM create_magic_link_token(join_email, 'join');

        RETURN QUERY
          SELECT
            FALSE                         AS is_verified,
            FALSE                         AS is_new_member,
            token_record.token            AS token,
            token_record.expires_at       AS expires_at;

      ELSE
      -- repeat email
        RETURN QUERY
          SELECT
            TRUE        AS is_verified,
            FALSE       AS is_new_member,
            ''          AS token,
            NOW()       AS expires_at;
      END IF;
    END;
  $$
LANGUAGE PLPGSQL;


-- SELECT is_verified, is_new_member, token, expires_at FROM join_member('email@example.com')
