select * from empregado;

create table empregado_backup as select * from empregado where 1= 2;

SELECT * FROM EMPREGADO_BACKUP;

CREATE OR REPLACE TRIGGER replicaInsEmp
After INSERT ON empregado
For each row
Begin
 Insert into empregado_backup values (:new.Matricula, :new.primeironome, :new.sobrenome, :new.dataadmissao, :new.cargo, :new.salario, :new.gerente,:new.coddepto);
End;

Insert into empregado values (10,'Jorge', 'Alberto',sysdate, 'Analista de Sistemas',3000, 1,1);

CREATE OR REPLACE TRIGGER replicaDelEmp
 Before delete on empregado
For each row
Begin
 Delete from empregado_backup
 Where matricula = :old.matricula;
End;

Delete from empregado where matricula = 10;

create table tabArtAudit(atualizacao number, ultima_data date);

CREATE OR REPLACE TRIGGER registra_atualizacoes
After update on artista
 declare qtd_linhas integer;
Begin
 select count(*) into qtd_linhas from tabArtAudit;
 if qtd_linhas = 0 then
 insert into tabArtAudit values(1,sysdate);
 else
 Update tabArtAudit
 Set atualizacao = atualizacao + 1, ultima_data =
sysdate;
 end if;
End;

update artista set pais = 'BRASIL' Where cod_artista = 7;
update artista set pais = 'BRASIL' Where cod_artista = 8;
Select * from tabArtAudit;

create table empregado2 as select * from hr.employees;

CREATE TABLE Empregado2 
   (EMPLOYEE_ID NUMBER, 
    FIRST_NAME VARCHAR2(20), 
    LAST_NAME VARCHAR2(25) NOT NULL, 
    EMAIL VARCHAR2(25) NOT NULL, 
    PHONE_NUMBER VARCHAR2(20), 
    HIRE_DATE DATE NOT NULL, 
    JOB_ID VARCHAR2(10) NOT NULL, 
    SALARY NUMBER(8,2), 
    COMMISSION_PCT NUMBER(2,2), 
    MANAGER_ID NUMBER, 
    DEPARTMENT_ID NUMBER);
    
SELECT * FROM Empregado2;
    
Create or replace trigger logmod
before insert or update or delete on Empregado2
For each row
 declare v_modtipo char(1);
Begin
 If inserting then v_modtipo := 'I';
 elsif updating then v_modtipo := 'U';
 else v_modtipo := 'D';
 end if;
 dbms_output.put_line(v_modtipo || '--' || User || '--' || sysdate);
End;

update empregado2 set salary = salary * 1.2;
commit;

Create or replace trigger logmod
before insert or update or delete on Empregado2
 declare v_modtipo char(1);
Begin
 If inserting then v_modtipo := 'I';
 elsif updating then v_modtipo := 'U';
 else v_modtipo := 'D';
 end if;
 dbms_output.put_line(v_modtipo || '--' || User || '--' || sysdate);
End;
