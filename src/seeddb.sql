BEGIN;

-- AUTH
\i ./schemas/auth/tables/magic_link_type/seed.sql
\i ./schemas/auth/tables/magic_link/seed.sql

-- COMMUNITY
\i ./schemas/community/tables/member/seed.sql

\i ./schemas/community/tables/speaker_status/seed.sql
\i ./schemas/community/tables/speaker/seed.sql

\i ./schemas/community/tables/sponsor_status/seed.sql
\i ./schemas/community/tables/sponsorship_type/seed.sql
\i ./schemas/community/tables/sponsor/seed.sql
\i ./schemas/community/tables/sponsor_sponsorship_type/seed.sql

COMMIT;
