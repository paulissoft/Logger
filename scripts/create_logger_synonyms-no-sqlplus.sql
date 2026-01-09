-- Creates synonyms from defined user for Logger objects

/*
-- Parameters
define from_user = '&1' -- This is the user to reference Logger objects


whenever sqlerror exit sql.sqlcode
*/
create or replace synonym logger for logger_user.logger
/
create or replace synonym logger_logs for logger_user.logger_logs
/
create or replace synonym logger_logs_apex_items for logger_user.logger_logs_apex_items
/
create or replace synonym logger_prefs for logger_user.logger_prefs
/
create or replace synonym logger_prefs_by_client_id for logger_user.logger_prefs_by_client_id
/
create or replace synonym logger_logs_5_min for logger_user.logger_logs_5_min
/
create or replace synonym logger_logs_60_min for logger_user.logger_logs_60_min
/
create or replace synonym logger_logs_terse for logger_user.logger_logs_terse
/
