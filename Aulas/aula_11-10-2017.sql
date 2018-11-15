SELECT * FROM PRODUTO;

CREATE or replace VIEW Pr_quilo (codigo, descricao,unidade) AS Select codprod,descricao,unidade From produto Where unidade = 'KG';

Select * from Pr_quilo;

Select descricao from pr_quilo;

CREATE OR REPLACE VIEW Vend_sal(codigo,nome,salario) AS Select codvend,nome,salariofixo From vendedor WITH READ ONLY;

SELECT * FROM VENDEDOR;

Select * FROM Vend_sal;

Select nome from vend_sal;

Insert into PR_quilo values (110,'Arroz','KG');

Update PR_quilo Set descricao = 'Arroz Integral' Where codigo = 110;

Delete from PR_quilo Where descricao = 'Arroz Integral';

CREATE or replace VIEW Lista_pedidos AS Select nome, descricao From vendedor v 
join pedido p on v.codvend = p.codvend 
Join itenspedido i on p.numped = i.numped
join produto pr on i.codprod = pr.codprod
order by nome;

Select * from lista_pedidos;

Select descricao from lista_pedidos;

Select distinct descricao from lista_pedidos;

CREATE OR REPLACE VIEW Produto_descA AS SELECT codprod, descricao FROM produto WHERE descricao like 'A%' WITH CHECK OPTION;

Insert into Produto_descA values (40, 'Manteiga');
Insert into Produto_descA values (41, 'Azeite');

SELECT * FROM PRODUTO_DESCA;

Select nome from vend_sal vie join pedido p on vie.codigo = p.codvend; --join com a view (verificar as restrições)

Select nome from vendedor v join pedido p on v.codvend = p.codvend; --join com a tabela

select view_name, text from user_views;

Select Usuário, Constrainte, Tipo, Condição as owner,constraint_name, constraint_type, search_condition From user_constraints;

Select table_name, status, num_rows, tablespace_name From user_tables;



--1. Para a tabela artista, crie uma view artista_v com os seguintes campos: cod_artista, nome_artista, data_nascimento. 
--Renomeie cod_artista para código e nome_artista para nome na view. Liste o conteúdo da view criada.
SELECT * FROM ARTISTA;

CREATE OR REPLACE VIEW artista_v (codigo, nome, nascimento) AS Select cod_artista, nome_artista, data_nasc From artista;

SELECT * FROM ARTISTA_V;


--2. Crie uma view filme_v com os seguintes campos: titulo, duração, ano, estúdio (nome do estúdio). Liste, em seguida, seu conteúdo.
SELECT * FROM FILME;
SELECT * FROM ESTUDIO;
CREATE OR REPLACE VIEW filme_v (titulo, duração, ano, estúdio) AS Select titulo, duracao, ano, nome_estudio 
From FILME F JOIN ESTUDIO E ON F.COD_ESTUDIO = E.COD_ESTUDIO ;

SELECT * FROM filme_v;

--3. Faça a inserção da artista “Mariana Ximenes” com a data de nascimento ‘27/11/78’ através da view artista_v. Como foi possível inserir por meio da view? Explique.
INSERT INTO ARTISTA_V A (A.CODIGO, A.NOME, A.NASCIMENTO) VALUES (9, 'Mariana Ximenes', '27/11/78');
--R: Foi pssível inserir os dado, pois os campos "Cidade" e "País" da Tabela Artista podem receber valores nulos

--4. Tente inserir um filme através da view filme_v. O que aconteceu? Explique.
INSERT INTO FILME_V F (F.TITULO, F."DURAÇÃO", F.ANO, F."ESTÚDIO") VALUES ('American Pie', 117, 2008, '20th Fox Century');
--R O Campo Estudio está em outra tabela (Estudio) que não pode ser modificada, ja que o sql só modifica uma tabela por vez
--R Erro SQL: não é possível modificar mais de uma vez uma tabela de base através da view de junção 

--a. Faça a inserção através da tabela base filme. Depois consulte a view. O filme foi inserido?
INSERT INTO FILME F (F.COD_FILME, F.TITULO, F.DURACAO, F.ANO) VALUES (10, 'American Pie', 117, 2008);
SELECT * FROM FILME;
SELECT * FROM FILME_V;
--R: O filme não foi inserido! (o.O)

--5. Altere a data de nascimento da artista “Mariana Ximenes” para ‘28/11/1978’ através da view artista_v.
UPDATE ARTISTA_V A SET A.NASCIMENTO = '28/11/1978' where A.NOME='Mariana Ximenes';

--6. Delete um registro através da view artista_v.
DELETE FROM ARTISTA_V A WHERE A.NOME='Mariana Ximenes';


--7. Elimine a view filme_v.
DROP VIEW FILME_V;

ROLLBACK;






