SELECT * FROM PEDIDO;
SELECT * FROM CLIENTE;
SELECT * FROM DEPARTAMENTO;
SELECT * FROM EMPREGADO;


Select numped, c.nome as "Cliente", v.nome as "Vendedor" FROM cliente c JOIN pedido p on c.codcli = p.codcli JOIN vendedor v on p.codvend = v.codvend;

Select e.sobrenome as "Empregado", d.nome as "Departamento", e.dataadmissao as "Data de Admissão" From empregado e join departamento d on e.coddepto = d.coddepto;

Select e.sobrenome, d.nome, e.dataadmissao From empregado e join departamento d on e.coddepto = d.coddepto;

Select * from empregado natural JOIN departamento; --campos em comuns procurados automaticamente

Select e.primeironome, d.nome from empregado e natural JOIN departamento d;

Select e.primeironome as "Empregado", g.primeironome as "Gerente" From (empregado e join empregado g on e.gerente = g.matricula);

select d.nome as Departamento, e.primeironome as Empregado from departamento d left outer join empregado e on d.coddepto = e.coddepto; -- juncao + fora da esquerda (departamento sem empregado)

select d.nome as Departamento, e.primeironome as Empregado from departamento d join empregado e on d.coddepto = e.coddepto; -- join normal

UPDATE EMPREGADO SET CODDEPTO = null WHERE MATRICULA=6;

select d.nome as Departamento, e.primeironome as Funcionario from departamento d right outer join empregado e on d.coddepto = e.coddepto order by d.nome; -- juncao + fora da direita (empregado sem departamento)

select d.nome as Departamento, e.primeironome as Funcionario from departamento d full outer join empregado e on d.coddepto = e.coddepto;  -- juncao + fora todos (departamento sem empregado + empregado sem departamento)

Select d.nome as Departamento, e.primeironome as Funcionario From departamento d left join empregado e on d.coddepto = e.coddepto Where e.coddepto is null Order by d.nome; -- ant join inverso do join

Select sysdate "h:m:s" from dual;
Select sysdate as "data" from cliente;

CREATE TABLE Regiao (
Id number, 
Nome varchar2(20)

);

DROP TABLE "REGIÃO";

alter table regiao  add constraint pkid primary key(id);

CREATE SEQUENCE seq1;
CREATE SEQUENCE seqRegião;

Insert into Regiao values(seqRegião.nextval,'Norte');
Insert into Regiao values(seqRegião.nextval,'Nordeste');
Insert into Regiao values(seqRegião.nextval,'Sudeste');
Insert into Regiao values(seqRegião.nextval,'Norte');
Insert into Regiao values(seqRegião.nextval,'Centro Oeste');

SELECT * FROM REGIAO;

CREATE TABLE Regiao2 (
Id number, 
Nome varchar2(20),
constraint pkid2 primary key(id)
);




