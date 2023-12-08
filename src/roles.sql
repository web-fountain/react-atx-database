REVOKE CONNECT ON DATABASE <> FROM PUBLIC;
REVOKE CREATE ON DATABASE ALL FROM PUBLIC;


-- PERSPECTIVE IS FROM INSIDE A DATABASE (default postgres)

-- ROLES
CREATE ROLE "cluser_admin"
  SUPERUSER
  NOLOGIN;

CREATE ROLE "db_admin"
  NOLOGIN;

CREATE ROLE "dev"
  NOLOGIN;


-- GRANT ROLE
GRANT CREATE
  ON SCHEMA public
  TO dev;


-- GRANT ACCESS
GRANT SELECT, INSERT, UPDATE, DELETE
  ON ALL TABLES
  IN SCHEMA public
  TO dev;


-- USERS
CREATE ROLE dev1
  WITH LOGIN
  PASSWORD "postgres"
  IN ROLE dev;

CREATE ROLE dev2
  WITH LOGIN PASSWORD "postgres"
  IN ROLE dev;


-- GRANT ROLE TO USER
GRANT dev TO dev1;
GRANT dev TO dev2;

-- https://www.red-gate.com/simple-talk/databases/postgresql/postgresql-basics-roles-and-privileges


CREATE ROLE "db_admin"
  CREATEROLE
  NOLOGIN;

GRANT CREATE
  ON SCHEMA public
  TO db_admin;

GRANT CREATE
  ON SCHEMA auth
  TO db_admin;

GRANT ALL
  ON SCHEMA auth
  TO db_admin;
GRANT ALL
  ON ALL TABLES
  IN SCHEMA auth
  TO db_admin;


CREATE ROLE "roberto"
  WITH LOGIN
  PASSWORD 'admin'
  IN ROLE dev;
