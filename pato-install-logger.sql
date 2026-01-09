declare
  l_git_repo_index pato_cloud_repo.git_repo_index_t;
  l_files_to_install constant sys.odcivarchar2list :=
    sys.odcivarchar2list
    ( 'scripts/create_user-no-sqlplus.sql'
    , 'install/logger_install-no-sqlplus.sql'
    , 'scripts/grant_logger_to_user-no-sqlplus.sql'
    , 'scripts/create_logger_synonyms-no-sqlplus.sql'
    );
begin
  -- first call must be to paulissoft/oracle-tools branch development
  l_git_repo_index := 
    pato_cloud_repo.init_github_repo
    ( p_repo_owner => 'paulissoft'
    , p_repo_name => 'oracle-tools'
    , p_branch_name => 'development'
    );
  -- Start of installing paulissoft/Logger
  l_git_repo_index := 
    pato_cloud_repo.init_github_repo
    ( p_repo_owner => 'paulissoft'
    , p_repo_name => 'Logger'
    , p_branch_name => 'feature/#1'
    );
  for i_idx in l_files_to_install.first .. l_files_to_install.last
  loop
    begin
      pato_cloud_repo.install_file
      ( p_git_repo_index => l_git_repo_index
      , p_file_path => l_files_to_install(i_idx)
      , p_stop_on_error => true
      , p_schema => case i_idx
                      when l_files_to_install.first
                      then 'ADMIN'
                      when l_files_to_install.last
                      then 'ORACLE_TOOLS'
                      else 'LOGGER_USER'
                    end
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
