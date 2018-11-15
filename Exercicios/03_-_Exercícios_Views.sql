--1. Para a tabela artista, crie uma view artista_v com os seguintes campos: cod_artista, nome_artista, data_nascimento. 
--Renomeie cod_artista para c�digo e nome_artista para nome na view. Liste o conte�do da view criada.
SELECT * FROM ARTISTA;

CREATE OR REPLACE VIEW artista_v (codigo, nome, nascimento) AS Select cod_artista, nome_artista, data_nasc From artista;

SELECT * FROM ARTISTA_V;


--2. Crie uma view filme_v com os seguintes campos: titulo, dura��o, ano, est�dio (nome do est�dio). Liste, em seguida, seu conte�do.
SELECT * FROM FILME;
SELECT * FROM ESTUDIO;
CREATE OR REPLACE VIEW filme_v (titulo, dura��o, ano, est�dio) AS Select titulo, duracao, ano, nome_estudio 
From FILME F JOIN ESTUDIO E ON F.COD_ESTUDIO = E.COD_ESTUDIO ;

SELECT * FROM filme_v;

--3. Fa�a a inser��o da artista �Mariana Ximenes� com a data de nascimento �27/11/78� atrav�s da view artista_v. Como foi poss�vel inserir por meio da view? Explique.
INSERT INTO ARTISTA_V A (A.CODIGO, A.NOME, A.NASCIMENTO) VALUES (9, 'Mariana Ximenes', '27/11/78');
--R: Foi pss�vel inserir os dado, pois os campos "Cidade" e "Pa�s" da Tabela Artista podem receber valores nulos

--4. Tente inserir um filme atrav�s da view filme_v. O que aconteceu? Explique.
INSERT INTO FILME_V F (F.TITULO, F."DURA��O", F.ANO, F."EST�DIO") VALUES ('American Pie', 117, 2008, '20th Fox Century');
--R O Campo Estudio est� em outra tabela (Estudio) que n�o pode ser modificada, ja que o sql s� modifica uma tabela por vez
--R Erro SQL: n�o � poss�vel modificar mais de uma vez uma tabela de base atrav�s da view de jun��o 

--a. Fa�a a inser��o atrav�s da tabela base filme. Depois consulte a view. O filme foi inserido?
INSERT INTO FILME F (F.COD_FILME, F.TITULO, F.DURACAO, F.ANO) VALUES (10, 'American Pie', 117, 2008);
SELECT * FROM FILME;
SELECT * FROM FILME_V;
--R: O filme n�o foi inserido! (o.O)

--5. Altere a data de nascimento da artista �Mariana Ximenes� para �28/11/1978� atrav�s da view artista_v.
UPDATE ARTISTA_V A SET A.NASCIMENTO = '28/11/1978' where A.NOME='Mariana Ximenes';

--6. Delete um registro atrav�s da view artista_v.
DELETE FROM ARTISTA_V A WHERE A.NOME='Mariana Ximenes';


--7. Elimine a view filme_v.
DROP VIEW FILME_V;