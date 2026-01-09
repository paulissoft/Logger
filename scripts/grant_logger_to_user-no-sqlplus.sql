-- Grants privileges for logger objects from current user to a defined user

/*
-- Parameters
define to_user = '&1' -- This is the user to grant the permissions to


whenever sqlerror exit sql.sqlcode
*/

grant execute on logger_user.logger to oracle_tools
/
grant select, delete on logger_user.logger_logs to oracle_tools
/
grant select on logger_user.logger_logs_apex_items to oracle_tools
/
grant select, update on logger_user.logger_prefs to oracle_tools
/
grant select on logger_user.logger_prefs_by_client_id to oracle_tools
/
grant select on logger_user.logger_logs_5_min to oracle_tools
/
grant select on logger_user.logger_logs_60_min to oracle_tools
/
grant select on logger_user.logger_logs_terse to oracle_tools
/
