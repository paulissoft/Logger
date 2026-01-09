/*
-- Script: pato-install-logger.sql
-- Goal  : Install Logger via PATO
*/

whenever sqlerror exit failure

alter session set current_schema = ADMIN
/

create user LOGGER_USER no authentication default tablespace DATA temporary tablespace TEMP
/

alter user LOGGER_USER quota unlimited on DATA
/

grant connect,create view, create job, create table, create sequence, create trigger, create procedure, create any context to LOGGER_USER
/

declare
  l_github_access_handle varchar2(256);
  l_files_to_install constant sys.odcivarchar2list :=
    sys.odcivarchar2list
    ( 'install/logger_install-no-sqlplus.sql'
    , 'scripts/grant_logger_to_user-no-sqlplus.sql'
    , 'scripts/create_logger_synonyms-no-sqlplus.sql'
    );
begin
  admin_install_pkg.delete_github_access; -- delete all
  -- first call must be to paulissoft/oracle-tools branch development
  admin_install_pkg.set_github_access
  ( p_repo_owner => 'paulissoft'
  , p_repo_name => 'oracle-tools'
  , p_branch_name => 'development'
  , p_github_access_handle => l_github_access_handle
  );
  -- second call must be to paulissoft/Logger
  admin_install_pkg.set_github_access
  ( p_repo_owner => 'paulissoft'
  , p_repo_name => 'Logger'
  , p_branch_name => 'feature/#1'
  , p_github_access_handle => l_github_access_handle
  );
  -- Start of installing paulissoft/Logger
  for i_idx in l_files_to_install.first .. l_files_to_install.last
  loop
    begin
      admin_install_pkg.install_file
      ( p_github_access_handle => l_github_access_handle
      , p_schema => case i_idx
                      when l_files_to_install.last
                      then 'ORACLE_TOOLS'
                      else 'LOGGER_USER'
                    end
      , p_file_path => l_files_to_install(i_idx)
      , p_stop_on_error => true
      );
    exception
      when others
      then
        raise_application_error(-20000, l_files_to_install(i_idx), true);
    end;
  end loop;
  -- End of installing paulissoft/Logger
end;
/
