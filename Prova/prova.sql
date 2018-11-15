CREATE TABLE Empregado (
Matricula number,
PrimeiroNome varchar2(15),
sobrenome varchar2(15),
Dataadmissao date,
Cargo varchar2(30),
Salario number(13,2),
gerente number,
Coddepto number);
alter table empregado add CONSTRAINT pkemp PRIMARY KEY (matricula);

CREATE TABLE dependente(
Matricula number,
Num number,
PrimeiroNome varchar2(15),
Sobrenome varchar2(15));

alter table dependente add CONSTRAINT pkDep PRIMARY KEY (matricula, num);
alter table Dependente add CONSTRAINT fkdep FOREIGN KEY (matricula) references Empregado;

-- questao 1
--1.1 pkemp , pkDep e fkdep

--1.2 Sim:  pkemp , pkDep

--1.3 as buscas se tornam mais r�pidas e otimizadas com os indices

--1.4 custo de processamento e de armazenamento de metadados

--1.5 --indice criado pois esta coluna provavelmente ser� umas das mais consultadas
create index SNENPREG on Empregado(sobrenome); 

-- questao 2

INSERT INTO empregado (Matricula, PrimeiroNome, sobrenome, Dataadmissao, Cargo, Salario, gerente, Coddepto)
VALUES (1,'Jos�','Carlos', '01/01/2000','motorista',1500,1,1);
INSERT INTO empregado (Matricula, PrimeiroNome, sobrenome, Dataadmissao, Cargo, Salario, gerente, Coddepto)
VALUES (2,'Maria','Alice', '01/01/2015','secret�ria',1800,1,2);
INSERT INTO empregado (Matricula, PrimeiroNome, sobrenome, Dataadmissao, Cargo, Salario, gerente, Coddepto)
VALUES (3,'jo�o','Rodrigues', '01/11/2005','administrador',2500,1,3);

create or replace procedure insDepend is
cursor select_emp is select matricula from empregado;
mat empregado.matricula%type;
begin

for v_sel in select_emp loop
    insert into DEPENDENTE (Matricula, Num, PrimeiroNome, Sobrenome) values (v_sel.matricula, 1, 'T', 'teste' );
    insert into DEPENDENTE (Matricula, Num, PrimeiroNome, Sobrenome) values (v_sel.matricula, 2, 'T', 'teste' );
end loop;

end;

exec insDepend;
select * from dependente; 

--questao 4 
--As exce��es servem para mostrar os erros de saida quando certos comandos sql s�o executados. Elas podem parar o bloco de execu��o ou n�o

--exp 1
declare
mat number;
begin
select matricula into mat from EMPREGADO WHERE CODDEPTO=4;
exception
when no_data_found then --exececao pr� definida pelo oracle quando n�o encontra dados so select
DBMS_OUTPUT.PUT_LINE('Matricula n�o encontrada');
end;

--exp 2
declare SAL_ABAIXO exception;
faixa number;
begin
select salario into faixa from EMPREGADO where matricula = 1;
if (faixa < 1000) then
    update empregado set salario= '2000';  
end if;
RAISE SAL_ABAIXO;
exception
when SAL_ABAIXO then -- excecao definida pelo desenvolvedor
DBMS_OUTPUT.PUT_LINE('Salario abaixo');
end;

--questao 5

create or replace trigger verificaSalario
before insert or update  of salario on empregado 
for each row
declare SAL_ACIMA exception;
SAL_ABAIXO exception;
begin
    if :new.salario < 7000 then
        raise SAL_ABAIXO;
    elsif :new.salario > 25000 then
        raise SAL_ACIMA;
    end if;
exception
when SAL_ABAIXO then 
    DBMS_OUTPUT.PUT_LINE('Salario fora da faixa: abixo de 7000');
when SAL_ACIMA then 
    DBMS_OUTPUT.PUT_LINE('Salario fora da faixa: acimna de 25000');
end;


INSERT INTO empregado (Matricula, PrimeiroNome, sobrenome, Dataadmissao, Cargo, Salario, gerente, Coddepto)
VALUES (4,'Jo�o','C�sar', '01/01/1999','estagiario',1500,1,1);
INSERT INTO empregado (Matricula, PrimeiroNome, sobrenome, Dataadmissao, Cargo, Salario, gerente, Coddepto)
VALUES (5,'Jo�o','C�sar', '01/01/1999','estagiario',30000,1,1);

commit;

--questao 6
 -- trigger � um gatilho que � disparado quando um comando espicificado do SQL(insert, updade ou delete) � executado, 
 -- j� a funcao � um bloco de comandos que executam e retorna um valor a ser atribu�do a uma vari�vel
 
 --O triger deve ser criado quando h� necessidade de manipulacao de dados do banco sem a interven��o do desenvolvedor ou da aplica��o. Deve ser usado antes ou apos um comando DML  
 --a Fun��o deve ser criada quando h� necessidade de um retorno de um determinado valor. Dever ser usada dentro de um bloco an�nimo ou dentro de um trigger ou de uma procedure

--exp funcao

create or replace function ContaEmpregados 
return number is
cont number;
begin
select COUNT(Matricula) into cont from empregado;
return cont;
end;

--exp trigger

create or replace trigger insDep
after insert on empregado
begin
     insert into DEPENDENTE (Matricula, Num, PrimeiroNome, Sobrenome) values (1, 1, 'T', 'TESTE' );
end;

