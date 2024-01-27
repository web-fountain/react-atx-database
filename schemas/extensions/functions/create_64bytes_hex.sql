SET search_path TO extensions;


CREATE OR REPLACE FUNCTION
  create_64bytes_hex()
RETURNS TEXT AS
  $$
    BEGIN
      RETURN encode(gen_random_bytes(64), 'hex');
    END;
  $$
LANGUAGE PLPGSQL;
