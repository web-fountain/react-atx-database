BEGIN;

-- AUTH
\i ./schemas/auth/tables/magic_link_type/seed.sql
\i ./schemas/auth/tables/magic_link/seed.sql

-- COMMUNITY
\i ./schemas/community/tables/member/seed.sql

COMMIT;
