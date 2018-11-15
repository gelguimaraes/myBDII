Create table GuardaTruncates(
quando date default sysdate,
quem varchar2(20) default user,
Onde varchar2(20));

Create or replace trigger RegistraTruncates
After truncate on schema
Begin
Insert into GuardaTruncates(onde) values(ora_dict_obj_name);
End;

truncate table testa_bloco;
select * from guardaTruncates;

truncate table TOP;
select* from TOP;
select * from guardaTruncates;

CREATE OR REPLACE TRIGGER RegistraSalarioEMP
AFTER UPDATE ON empregado
FOR EACH ROW
WHEN (NEW.matricula > 0)
DECLARE diferenca_salario number;
BEGIN
    diferenca_salario := :NEW.SALARIO - :OLD.SALARIO;
    dbms_output.put_line('Salário antigo:' || :OLD.salario || chr(13));
    dbms_output.put_line('Salário novo:' || :NEW.salario || chr(13));
    dbms_output.put_line(' A diferença de salário foi de: ' || diferenca_salario);
END;

select salario from Empregado; 

UPDATE EMPREGADO SET SALARIO = 10000;

commit;

Create or Replace trigger impedeInsercao
Before insert or update On empregado
Declare
v_hoje number;
v_agora number;
Begin
    v_hoje := to_number(to_char(sysdate,'d'));
    v_agora := to_number(to_char(sysdate,'hh24mi'));
    If inserting or updating then
        If v_agora > 1330 then
            Raise_application_error(-20400,'Hora proibida para atualizações');
        End if;
        If v_hoje = 1 then
            Raise_application_error(-20600,'Dia proibido para atualizações');
        End if;
    End if;
End;

show ERRORS;

insert into empregado values (11,'Teste','xxx',sysdate,1,3450,1,1);

alter trigger impedeinsercao disable;

alter trigger RegistraSalarioEMP disable;

CREATE OR REPLACE TRIGGER testa_salario
BEFORE INSERT OR UPDATE OF salario ON empregado
FOR EACH ROW
declare salario_alto exception;
Begin
If :new.salario > 20000 then
raise salario_alto;
end if;
exception
when salario_alto then
Dbms_output.put_line('Valor de salário superior ao limite máximo permitido');
end;


Update empregado set salario = 22000 where matricula = 6;

commit;
select salario from empregado where matricula = 6;

CREATE OR REPLACE TRIGGER testa_salario
BEFORE INSERT OR UPDATE OF salario ON empregado
FOR EACH ROW
declare salario_alto exception;
Begin
If :new.salario > 20000 then
raise salario_alto;
end if;
exception
when salario_alto then
Raise_application_error(-20500,'Tentativa de aumento exagerada!!!');
end;

Update empregado set salario = 23000 where matricula = 7;
commit;

select salario from empregado where matricula = 7;

Create or replace view vPessoas as
select nome as nome, 'c' as tipo
from cliente
Union
Select nome, 'v' from vendedor;

Create or replace trigger insViewVPessoas
Instead of insert on vPessoas
Declare v_cod_vend number;
V_cod_cli number;
Begin
    Select max(codvend)+1 into v_cod_vend from vendedor;
    Select max(codcli)+1 into v_cod_cli from cliente;
        If :new.tipo = 'c' then
    Insert into cliente(codcli, nome) values (v_cod_cli, :new.nome);
    Else
        Insert into vendedor (codvend,nome) values (v_cod_vend,:new.nome);
    End if;
End;


insert into vPessoas values('Mercia','v');

Select * from vendedor;

select * from vPessoas;
select * from cliente;

insert into vPessoas values('José','c');

insert into artista_v values ('12','teste','16/12/1980' );

select * from artista; 

Create or Replace Trigger emp_trig
Before Update of first_name on empregado2
For each row
Begin
    Dbms_output.put_line ('First name '||:old.first_name|| ' mudou para '||:new.first_name);
End;

update empregado2 e2 set e2.FIRST_NAME = 'teste' where e2.DEPARTMENT_ID = 50 ; 
commit;

--O que ele faz?
--imprime na saida dbms os valores dos nomes antigo e novo de empregado
-- Como você realizou o teste do trigger? Como ele foi “disparado”?

-- O que são os objetos “old” e “new”?
--old valor antigo, new valor novo


CREATE TABLE emp_log (
usuario varchar2(20), 
operacao varchar2(10), 
data_operacao date );

Create or replace trigger Log_emp
after insert or update or delete on empregado
Begin
    if inserting then
        insert into emp_log values(user, 'INSERT', sysdate);
    end if ;
    if updating then
        insert into emp_log values(user, 'UPDATE', sysdate);
    end if ;
    if deleting then
        insert into emp_log values(user, 'DELETE', sysdate);
    end if ;
End;

INSERT INTO empregado (MATRICULA, PRIMEIRONOME, SOBRENOME, DATAADMISSAO, SALARIO) VALUES ('11', 'teste', 'teste', '16/11/2000','20000' );

commit;

select * from EMP_LOG;

--O que ele faz?
--insere dados na tabela emp_log 
--Como foi “disparado”?
--depois que um insert, updade ou delete é feito na tabela empregado
--Onde você viu o resultado?
--select * from EMP_LOG;

CREATE TABLE testeINC (
ID NUMBER NOT NULL,
Descricao VARCHAR2(50) NOT NULL);
ALTER TABLE testeINC ADD CONSTRAINT teste_pk PRIMARY KEY (ID);


--Crie um trigger para realizar um autoincremento (em ID) sempre que a tabela testeINC for inserida.
--Use: SELECT NVL(MAX(id),0) +1 INTO contador FROM testeINC;
--Teste com três inserts como esse: insert into testeINC(descricao) values('X');

Create or replace trigger AUT_INC_TESTE_INC
before insert on testeINC
for each row
declare contador number;
begin
    contador:=0;
    SELECT NVL(MAX(id),0)+1 INTO contador FROM testeINC;
    :new.ID := contador;
end;

insert into testeINC(descricao) values('X');
insert into testeINC(descricao) values('Y');
insert into testeINC(descricao) values('Z');

select * from testeINC;


--Para a tabela ARTISTA, crie um trigger que calcule a idade do artista que está sendo inserido. 
--Se essa idade for menor que 14, impeça a inserção e retorne um erro com a mensagem ‘Pessoa muito jovem para este papel!’.
--a) Teste com um artista menor que 14.
--b) Em seguida, teste com um artista maior que 14.
--c) O trigger foi definido “BEFORE” ou “AFTER”?
Create or replace trigger CALC_IDADE_ART
Before insert on ARTISTA
For Each Row
Declare idade_error exception;
idade number;

Begin
    idade :=  EXTRACT(YEAR FROM sysdate) - EXTRACT(YEAR FROM :new.data_nasc); 
    If idade < 14 then
        raise idade_error;
    end if;
    exception when idade_error then
        Raise_application_error(-20500,'Pessoa muito jovem para este papel!');
end;

INSERT INTO ARTISTA (COD_ARTISTA, NOME_ARTISTA, DATA_NASC) VALUES ('16','teste','11/12/2016');
INSERT INTO ARTISTA (COD_ARTISTA, NOME_ARTISTA, DATA_NASC) VALUES ('18','teste','11/12/2000');

commit;


