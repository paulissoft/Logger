declare
  procedure execute_immediate(p_statement in varchar2)
  is
  begin
    execute immediate p_statement;
  exception
    when others
    then raise_application_error(-20000, p_statement, true);
  end;
begin
  execute_immediate('create user LOGGER_USER no authentication default tablespace DATA temporary tablespace TEMP');
  execute_immediate('alter user LOGGER_USER quota unlimited on DATA');
  execute_immediate('grant connect,create view, create job, create table, create sequence, create trigger, create procedure, create any context to LOGGER_USER');
end;  
/

