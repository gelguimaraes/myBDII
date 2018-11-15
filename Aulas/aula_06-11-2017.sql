SELECT rowid FROM CLIENTE;

CREATE TABLE c (c1 INT, c2 INT);
CREATE INDEX ci ON c (c1, c2);
ALTER TABLE c ADD CONSTRAINT cpk PRIMARY KEY (c1,c2) USING INDEX ci;

CREATE TABLE d (d1 INT, d2 INT);
ALTER TABLE d ADD CONSTRAINT dpk PRIMARY KEY (d1,d2);

SELECT * FROM USER_CONSTRAINTS;

SELECT * FROM IND;

CREATE TABLE testeIn (id number, maior number, menor number, nome varchar2(10));
Insert into testeIn values (1,200,30,'X');
Insert into testeIn values(2, 300,23,'Y');
Insert into testeIn values(3, 200,30,'Z');

SELECT nome FROM testeIn WHERE maior = 200 AND menor = 30;

CREATE INDEX idx_testeIn_maior_menor ON testeIn (maior, menor);

SELECT * FROM FILME where ano='2006';

CREATE INDEX anoIn ON FILME(ano);

create table testaEmp as (select * from empregado);
DECLARE
    I INT := 0;
    BEGIN
         WHILE I <= 200000 LOOP
             INSERT INTO TESTAEMP select * from empregado;
             I := I + 1;
         END LOOP;
END;

select * from testaemp;

select primeironome,cargo from testaemp where cargo like 'chefe'; 

EXPLAIN PLAN FOR select primeironome,cargo from testaemp where cargo like 'chefe'; 

SELECT * FROM   TABLE(DBMS_XPLAN.DISPLAY);

create index teste_indice on testaemp(cargo);

select primeironome,cargo from testaemp where cargo like 'chefe'; 

EXPLAIN PLAN FOR select primeironome,cargo from testaemp where cargo like 'chefe'; 

SELECT * FROM   TABLE(DBMS_XPLAN.DISPLAY);

create index teste_indice on testaemp(cargo);

--desconectar

select primeironome,cargo from testaemp where cargo like 'chefe'; 

EXPLAIN PLAN FOR select primeironome,cargo from testaemp where cargo like 'chefe'; 

SELECT * FROM   TABLE(DBMS_XPLAN.DISPLAY);


DROP index test_indice;

create index teste_indice on testaemp(matricula);

SELECT matricula, primeironome FROM Empregado order by matricula;

EXPLAIN PLAN FOR SELECT matricula, primeironome FROM Empregado order by matricula;

SELECT * FROM   TABLE(DBMS_XPLAN.DISPLAY);

select matricula, primeironome from TESTAEMP order by matricula; 

EXPLAIN PLAN FOR select matricula, primeironome from TESTAEMP order by matricula; 

SELECT * FROM   TABLE(DBMS_XPLAN.DISPLAY);

create index teste_indice_matricula on testaemp(matricula);


