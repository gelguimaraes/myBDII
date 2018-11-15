CREATE TABLE Disciplina (
Cod_DISC NUMBER NOT NULL,
Nome_DISC VARCHAR2(30),
CONSTRAINT PK_Disciplina PRIMARY KEY(Cod_DISC));

CREATE TABLE Professor ( Matric_prof VARCHAR2(6) NOT NULL, Nome_prof VARCHAR2(40), Data_admissao DATE );

ALTER TABLE Professor ADD CONSTRAINT PK_Professor PRIMARY KEY(Matric_prof);

ALTER TABLE professor add cod_disc number;

ALTER TABLE professor ADD CONSTRAINT FK_prof_disc FOREIGN KEY (cod_disc) REFERENCES Disciplina;

Insert into DISCIPLINA values ('1','BD1');
Insert into DISCIPLINA values ('2','Sistemas Operacionais');

Insert into PROFESSOR values(1,'Cristiane', null, 1);
Insert into PROFESSOR values(2,'Damires', null, 1);
Insert into PROFESSOR values(3,'Luciana', null, 2);

SELECT * FROM DISCIPLINA;

SELECT * FROM PROFESSOR;

DELETE FROM DISCIPLINA WHERE COD_DISC=1;

ALTER TABLE professor DROP CONSTRAINT fk2_prof_disc;

ALTER TABLE professor ADD CONSTRAINT FK2_prof_disc FOREIGN KEY(cod_disc) REFERENCES Disciplina ON DELETE SET NULL; 

DELETE FROM DISCIPLINA WHERE COD_DISC=1;

ROLLBACK;

ALTER TABLE professor DROP CONSTRAINT fk2_prof_disc;

ALTER TABLE professor ADD CONSTRAINT FK2_prof_disc FOREIGN KEY(cod_disc) REFERENCES Disciplina ON DELETE CASCADE; 

DELETE FROM DISCIPLINA WHERE COD_DISC=1;


ALTER TABLE professor DROP CONSTRAINT fk2_prof_disc;

ALTER TABLE professor ADD CONSTRAINT FK2_prof_disc FOREIGN KEY(cod_disc) REFERENCES Disciplina; 

DROP TABLE disciplina;

CREATE TABLE fornecedor (
id_fornecedor number,
nome_fornecedor varchar2(40),
CONSTRAINT check_fornecedor CHECK (id_fornecedor BETWEEN 100 and 9999) );

Insert into fornecedor values(1, 'XXX');

SELECT * FROM FORNECEDOR;

ALTER TABLE professor ADD salario number(15,2);
ALTER TABLE professor ADD CONSTRAINT prof_sal CHECK (salario >= 3000.00 and salario <= 12000.00);

SELECT * FROM PROFESSOR;

update professor set salario = 13000 where matric_prof = 1;


SELECT * FROM VENDEDOR;
SELECT * FROM CLIENTE;
SELECT * FROM PRODUTO;
SELECT * FROM PEDIDO;
SELECT * FROM ITENSPEDIDO;

SELECT * FROM ARTISTA;
SELECT * FROM CATEGORIA;
SELECT * FROM FILME;
SELECT * FROM ESTUDIO;
SELECT * FROM PERSONAGEM;


INSERT INTO FILME VALUES (8, 'Efeito Borboleta', '2006', 130, 6, 3);

INSERT INTO ARTISTA VALUES (8, 'Raul Júlia', null, 'Porto Rico', '09/03/1940');

INSERT INTO PERSONAGEM VALUES (8,8, 'Bison', 50000);

INSERT INTO FILME VALUES (9, 'Street Fight', '2006', 120, 1, 3);

UPDATE PERSONAGEM
  SET COD_FILME = 9 WHERE COD_ARTISTA = 8;


SELECT * FROM CLIENTE;
SELECT * FROM PEDIDO;

Select nome, p.numped from cliente cross JOIN pedido p;

Select cliente.codcli, nome, numped, pedido.codcli from cliente, pedido where cliente.codcli = pedido.codcli;

Select cliente.codcli, nome, numped, pedido.codcli from cliente JOIN pedido on cliente.codcli = pedido.codcli;

select v.nome from vendedor v join pedido p on v.codvend = p.codvend join itenspedido i on p.numped = i.numped join produto pr on i.codprod = pr.codprod where i.quantidade > 5 and pr.descricao = 'Chocolate';

Select cidade as CIDADES, count(*) as QUANTIDADE 
from cliente C, pedido P, vendedor V
where C.codcli = P.codcli and
P.codvend = V.codvend
Group by cidade;
