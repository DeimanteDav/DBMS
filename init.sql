-- Convenience script to recreate the whole schema and sample data
-- Usage:
--   psql -d tool_rental -f init.sql

\i drop.sql
\i create.sql
\i trg_validate_customer_phone.sql
\i trg_set_default_enddate.sql
\i view.sql
\i materialized_view.sql
\i data.sql
