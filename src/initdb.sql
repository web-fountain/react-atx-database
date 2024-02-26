BEGIN;

\i ./schemas/create.sql


-- EXTENSIONS
\i ./schemas/extensions/default.sql
\i ./schemas/extensions/functions/create_64bytes_hex.sql
\i ./schemas/extensions/functions/UUIDv7.sql


-- AUTH
\i ./schemas/auth/domains/email.sql
\i ./schemas/auth/functions/create_magic_link_token.sql
\i ./schemas/auth/functions/validate_magic_link_token.sql
\i ./schemas/auth/tables/magic_link_type/index.sql
\i ./schemas/auth/tables/magic_link_token/index.sql


-- COMMUNITY
\i ./schemas/community/domains/email.sql
\i ./schemas/community/functions/join_member.sql
\i ./schemas/community/tables/member/index.sql

\i ./schemas/community/tables/speaker_status/index.sql
\i ./schemas/community/tables/speaker/index.sql

\i ./schemas/community/tables/sponsor_status/index.sql
\i ./schemas/community/tables/sponsor/index.sql
\i ./schemas/community/tables/sponsorship_type/index.sql
\i ./schemas/community/tables/sponsor_sponsorship_type/index.sql

COMMIT;
