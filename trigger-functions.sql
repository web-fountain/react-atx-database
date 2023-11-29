SET search_path TO community;


/*
 * TRIGGER FUNCTIONS
 * https://www.reddit.com/r/PostgreSQL/comments/mnj9gx/automatically_add_createdat_updatedadd_values_to/
 */
CREATE OR REPLACE FUNCTION trfn_update_at()
  RETURNS TRIGGER
  LANGUAGE 'plpgsql'
AS $$
  BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  END;
$$
