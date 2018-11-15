INSERT INTO empregado VALUES (7, 'Renato',
'Martins', sysdate, 'chefe', 4500, 1,1);
SAVEPOINT sp1;
INSERT INTO empregado VALUES (8, 'Marcia', 'Guerra',
sysdate, 'balconista', 5500, 1,2);
select * from empregado;
COMMIT;


INSERT INTO empregado VALUES (9, 'Andrea',
'Gomes',sysdate, 'chefe', 4700, 1,1);
SELECT * FROM empregado;
Savepoint sp2;
INSERT INTO empregado VALUES (10, 'Carmem',
'Gomes',sysdate, 'diretor', 3700, 1,1);
SELECT * FROM empregado;
ROLLBACK to sp2;
SELECT * FROM empregado;
Commit; 

UPDATE empregado
SET salario = 6000
WHERE primeironome = 'Andrea';
SAVEPOINT R_sal;
UPDATE empregado
SET salario = 6500
WHERE primeironome = 'Marcia';
SAVEPOINT M_sal;
SELECT SUM(salario) FROM empregado;
ROLLBACK TO SAVEPOINT R_sal;
SELECT SUM(salario) FROM empregado;
UPDATE empregado
SET salario = 6000
WHERE primeironome = 'Marcia';
COMMIT;

Declare nomevar varchar2(30);
Begin
 UPDATE empregado
 SET salario = 4000
 WHERE matricula = 7;
 SELECT primeironome into
nomevar
 FROM empregado
 WHERE matricula = 7;
 COMMIT;
End;
