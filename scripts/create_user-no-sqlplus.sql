begin
  execute immediate 'create user LOGGER_USER no authentication default tablespace DATA temporary tablespace TEMP';
  execute immediate 'alter user LOGGER_USER quota unlimited on DATA';
  execute immediate 'grant connect,create view, create job, create table, create sequence, create trigger, create procedure, create any context to LOGGER_USER';
  execute immediate 'alter user LOGGER_USER lock account';
end;
/
