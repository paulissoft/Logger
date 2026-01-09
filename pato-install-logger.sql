declare
  l_git_repo_index pato_cloud_repo.git_repo_index_t;
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
  pato_cloud_repo.install_file
  ( p_git_repo_index => l_git_repo_index
  , p_file_path => 'scripts/create_user-no-sqlplus.sql'
  , p_stop_on_error => false
  , p_schema => 'ADMIN'
  );
  pato_cloud_repo.install_file
  ( p_git_repo_index => l_git_repo_index
  , p_file_path => 'install/logger_install-no-sqlplus.sql'
  , p_stop_on_error => false
  , p_schema => 'LOGGER_USER'
  );
  pato_cloud_repo.install_file
  ( p_git_repo_index => l_git_repo_index
  , p_file_path => 'scripts/grant_logger_to_user-no-sqlplus.sql'
  , p_stop_on_error => false
  , p_schema => 'LOGGER_USER'
  );
  pato_cloud_repo.install_file
  ( p_git_repo_index => l_git_repo_index
  , p_file_path => 'scripts/create_logger_synonyms-no-sqlplus.sql'
  , p_stop_on_error => false
  , p_schema => 'LOGGER_USER'
  );
  -- End of installing paulissoft/Logger
end;
/
