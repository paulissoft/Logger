-- Grants privileges for logger objects from a user to another user


-- Parameters
define from_user = '&1' -- This is the user to grant the permissions from
define to_user = '&2' -- This is the user to grant the permissions to

whenever sqlerror exit sql.sqlcode

grant execute on &from_user..logger to &to_user;
grant select, delete on &from_user..logger_logs to &to_user;
grant select on &from_user..logger_logs_apex_items to &to_user;
grant select, update on &from_user..logger_prefs to &to_user;
grant select on &from_user..logger_prefs_by_client_id to &to_user;
grant select on &from_user..logger_logs_5_min to &to_user;
grant select on &from_user..logger_logs_60_min to &to_user;
grant select on &from_user..logger_logs_terse to &to_user;
