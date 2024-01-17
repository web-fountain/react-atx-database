BEGIN;

\i ./schemas/create.sql
\i ./schemas/extensions/default.sql

-- AUTH
\i ./schemas/auth/domains/email.sql
\i ./schemas/auth/tables/magic_link_type/index.sql
\i ./schemas/auth/tables/magic_link/index.sql

-- COMMUNITY
\i ./schemas/community/domains/email.sql
\i ./schemas/community/tables/member/index.sql

\i ./schemas/community/tables/speaker_status/index.sql
\i ./schemas/community/tables/speaker/index.sql

\i ./schemas/community/tables/sponsor_status/index.sql
\i ./schemas/community/tables/sponsor/index.sql
\i ./schemas/community/tables/sponsorship_type/index.sql
\i ./schemas/community/tables/sponsor_sponsorship_type/index.sql

COMMIT;
