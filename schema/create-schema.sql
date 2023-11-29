CREATE SCHEMA IF NOT EXISTS community
  AUTHORIZATION "db_admin";
CREATE SCHEMA IF NOT EXISTS auth
  AUTHORIZATION "db_admin";


GRANT CREATE
  ON SCHEMA public
  TO "db_admin";

GRANT ALL
  ON SCHEMA community
  TO "react-atx";
GRANT ALL
  ON SCHEMA auth
  TO "react-atx";
