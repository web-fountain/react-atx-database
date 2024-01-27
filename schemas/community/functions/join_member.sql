SET search_path TO community;


CREATE OR REPLACE FUNCTION
  join_member(join_email TEXT)
RETURNS TABLE (email TEXT, is_verified BOOLEAN, is_new_member BOOLEAN) AS
  $$
    DECLARE
  member_record RECORD;

  BEGIN
    SELECT member.email, member.is_verified INTO member_record
    FROM "community".member
    WHERE member.email = join_email;

    IF NOT FOUND THEN
      RETURN QUERY
        INSERT INTO "community".member (email) VALUES (join_email)
        RETURNING
          member.email::TEXT AS email,
          member.is_verified::BOOLEAN AS is_verified,
          TRUE AS is_new_member;
    ELSE
      RETURN QUERY
        SELECT
          member_record.email::TEXT AS email,
          member_record.is_verified::BOOLEAN AS is_verified,
          FALSE AS is_new_member;
    END IF;
    END;
  $$
LANGUAGE PLPGSQL;


-- SELECT email, is_verified, is_new_member FROM join_member('email@example.com')
