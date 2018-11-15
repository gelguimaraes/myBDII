Create table testeTransacao (coluna1 number,coluna2 varchar2(10));
Alter table testeTransacao add constraint pk_t primary key(coluna1);
Create sequence seqt1;
Insert into testeTransacao values (seqt1.nextval,'AAA');
Insert into testeTransacao values (seqt1.nextval,'ABC');
Insert into testeTransacao values (seqt1.nextval,'BBB');
Insert into testeTransacao values (seqt1.nextval,'BCD');
Insert into testeTransacao values (seqt1.nextval,'CCC');
Insert into testeTransacao values (seqt1.nextval,'CDE');
Select * from testeTransacao;
savepoint spt1;
Insert into testeTransacao values (seqt1.nextval,'DDD');
Insert into testeTransacao values (seqt1.nextval,'DEF');
Insert into testeTransacao values (seqt1.nextval,'EEE');
Select * from testeTransacao;
rollback to spt1;

--a. Quantos registros existem na tabela TesteTransacao?
--9
-- Faça um rollback para spt1; quantos registros agora?
--6

alter table testeTransacao modify coluna2 varchar2(20);
Insert into testeTransacao values (seqt1.nextval,'EFG');
Insert into testeTransacao values (seqt1.nextval,'FFF');
Insert into testeTransacao values (seqt1.nextval,'FGH');
Select * from testeTransacao;
-- Quantos registros têm agora na tabela testeTransação?
--9
--Faça um rollback (geral) e tente desfazer todas as inserções. O que aconteceu?
Rollback; 
-- o Rollback voltou ate o ponto do savepoint

Create table ENGENHEIRO (cod_eng number, nome varchar2(30), salario number, 
CONSTRAINT PK_ENGENHEIRO PRIMARY KEY(Cod_eng));

Create table PROJETO (cod_proj number, titulo varchar2(30),  area varchar2(30), 
CONSTRAINT PK_PROJETO PRIMARY KEY(Cod_proj));

Create table ATUACAO (cod_proj number, cod_eng number,  funcao varchar2(30), 
CONSTRAINT PK_ATUACAO PRIMARY KEY(Cod_eng,Cod_proj), 
CONSTRAINT FK_atua_proj FOREIGN KEY (cod_proj) REFERENCES PROJETO, 
CONSTRAINT FK_atua_eng FOREIGN KEY (cod_eng) REFERENCES ENGENHEIRO );

INSERT INTO  ENGENHEIRO  VALUES (1, 'Joao Paulo', 3000);
INSERT INTO  ENGENHEIRO  VALUES (2, 'Jose Ricardo', 6000);
INSERT INTO  ENGENHEIRO  VALUES (3, 'Maria Alice', 8000);
INSERT INTO  ENGENHEIRO  VALUES (4, 'Paulo Ricardo', 7000);

INSERT INTO  PROJETO  VALUES (1, 'Segurança em redes', 'Redes');
INSERT INTO  PROJETO  VALUES (2, 'Business Inteligent', 'Negócios');
INSERT INTO  PROJETO  VALUES (3, 'Auto Eletric', 'Automação');

INSERT INTO  ATUACAO  VALUES (1, 1, 'Gerente');
INSERT INTO  ATUACAO  VALUES (2, 3, 'Desenvolvedor');
INSERT INTO  ATUACAO  VALUES (3, 2, 'Analista');

Commit;

--Verifique os nomes dos engenheiros que ganham acima da média
SELECT E.NOME FROM ENGENHEIRO E WHERE E.SALARIO > (SELECT AVG(E.SALARIO) FROM ENGENHEIRO E);
--Jose Ricardo, Maria Alice

--Mostre a quantidade de engenheiros por área
SELECT  P.AREA, COUNT(E.COD_ENG) as Engenheiros FROM ENGENHEIRO E JOIN ATUACAO A ON A.COD_ENG = E.COD_ENG 
JOIN PROJETO P ON P.COD_PROJ = A.COD_PROJ GROUP BY P.AREA;

select nome
from engenheiro
where cod_eng in (select cod_eng
 from atuacao
 where cod_proj in (select cod_proj
 from projeto
where area like 'Redes'));
--O que ele faz?
--Seleciona o nome do engenheiro que tem a area redes

--Reescreva-o usando JOIN. 
SELECT  E.NOME FROM ENGENHEIRO E JOIN ATUACAO A ON A.COD_ENG = E.COD_ENG 
JOIN PROJETO P ON P.COD_PROJ = A.COD_PROJ WHERE P.AREA like 'Redes';


select cod_eng
 from engenheiro
 where salario > 3000
 INTERSECT
 select cod_eng
 from atuacao;
--O que ele faz?
--Seleciona o codigo do engenheiro que tem o salario maior que 1200
--Refaça-o agora usando uma subquery.

SELECT E.COD_ENG FROM ENGENHEIRO E WHERE E.SALARIO > 3000 and E.COD_ENG IN (SELECT A.COD_ENG FROM ATUACAO A) ;

--Depois, refaça-o usando JOIN. 
SELECT E.COD_ENG FROM ENGENHEIRO E JOIN ATUACAO A ON A.COD_ENG=E.COD_ENG  WHERE E.SALARIO > 3000 ;


select cod_eng
 from engenheiro
MINUS
 select cod_eng
 from atuacao;
 
--O que ele faz?
--Seleciona os codigos do engenheiro menos os codigos do engenheiro que não estao em atuacao 

--Refaça-o agora usando uma subquery.
SELECT E.COD_ENG FROM ENGENHEIRO E WHERE E.COD_ENG NOT IN (SELECT A.COD_ENG FROM ATUACAO A);
SELECT E.COD_ENG FROM ENGENHEIRO E WHERE  NOT EXISTS (SELECT A.COD_ENG FROM ATUACAO A WHERE E.COD_ENG = A.COD_ENG);
--Depois, refaça-o usando JOIN (Utilize o left ou right join). 
SELECT E.COD_ENG FROM ENGENHEIRO E LEFT JOIN ATUACAO A ON A.COD_ENG = E.COD_ENG WHERE A.COD_ENG is NULL;
 
--Crie uma view mostrando os projetos (títulos) e seus engenheiros (nomes). Consulte-a.

CREATE or replace VIEW PROJ_ENG (NOMES, PROJETOS) AS SELECT E.NOME, P.TITULO FROM ENGENHEIRO E JOIN ATUACAO A ON A.COD_ENG = E.COD_ENG 
JOIN PROJETO P ON P.COD_PROJ = A.COD_PROJ ;
SELECT * FROM PROJ_ENG;


--Conceda o privilégio de select sobre a visão criada para seu colega. Peça para ele consultar a view. 

GRANT Select ON PROJ_ENG TO vitor;


