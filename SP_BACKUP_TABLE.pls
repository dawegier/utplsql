create or replace PROCEDURE SP_BACKUP_TABLE 
(
  var_table_name IN VARCHAR2 
) AS 
BEGIN
  declare 
    var_count number;
    var_table_name_backup varchar(100);
  begin
    
    var_table_name_backup := var_table_name || '_BACKUP';
  
    /*CHECK IF BACKUP ALREADY EXISTS... IF IT DOES THEN REMOVE OLD VERSION*/
    select count(*) into var_count from user_tables where UPPER(table_name) = UPPER(var_table_name_backup);
    if var_count > 0 then
      execute immediate 'drop table ' || var_table_name_backup;
    end if;
    
    /*CREATE NEW BACKUP*/
    execute immediate 'CREATE TABLE ' || var_table_name_backup || ' AS
         SELECT * FROM ' || var_table_name;
  end;
END SP_BACKUP_TABLE;
