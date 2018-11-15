--O que a seguinte consulta apresenta?
select titulo from filme where cod_estudio in 
(select cod_estudio from estudio where nome_estudio like 'P%');
--R: seleciona os filmes que possuem estudio começando com a letra P

-- Mostre as descrições de categorias que estão (associadas) na tabela Filme.
SELECT C.DESCRICAO_CATEG FROM CATEGORIA C WHERE C.COD_CATEG IN (SELECT F.COD_CATEG FROM FILME F);

-- Quem é o artista cujo nome de personagem é ‘Natalie’?
SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE A.COD_ARTISTA IN 
(SELECT P.COD_ARTISTA FROM PERSONAGEM P WHERE P.NOME_PERSONAGEM='Natalie' );

-- Existe algum artista cadastrado que não esteja na tabela Personagem?
SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE A.COD_ARTISTA NOT IN (SELECT P.COD_ARTISTA FROM PERSONAGEM P);
SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE NOT EXISTS (SELECT P.COD_ARTISTA FROM PERSONAGEM P WHERE P.COD_ARTISTA=A.COD_ARTISTA);

--Quais artistas estão na tabela Personagem?

SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE A.COD_ARTISTA IN (SELECT P.COD_ARTISTA FROM PERSONAGEM P);
SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE EXISTS (SELECT P.COD_ARTISTA FROM PERSONAGEM P WHERE P.COD_ARTISTA=A.COD_ARTISTA);

--Qual a média de caches existentes?
SELECT AVG(CACHE) as "Média dos Caches" FROM PERSONAGEM;

-- Mostre os nomes dos artistas que possuem cachê acima da média.
SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE A.COD_ARTISTA IN (SELECT P.COD_ARTISTA FROM PERSONAGEM P WHERE P.CACHE > (SELECT AVG(CACHE)FROM PERSONAGEM));

--O que a consulta apresenta?
Select distinct descricao_categ
From categoria c join filme f on c.cod_categ = f.cod_categ
Where duracao > Any (Select max(duracao) From filme fi
group by fi.cod_categ);

--R: Mostra A descrição das Categorias cujo os filmes tem duração maior que qualquer filme de sua categoria correspondente 
--OBS Coloquei o titulo para saber quais eram os filmes, mas pq Efeito Borboleta não aparece já que ele tem a duração maior que os filmes de sua categoria?
--INSERT INTO FILME VALUES (8, 'Efeito Borboleta', '2006', 130, 6, 3);

Select max(duracao) From filme fi group by fi.cod_categ;

--Crie uma tabela que mostre os filmes (títulos) e seus estúdios (nomes). Insira um novo registro na tabela criada. Consulte a tabela.

CREATE TABLE filmesEstudios AS
select titulo, e.nome_estudio 
from filme f join estudio e on e.COD_ESTUDIO =
f.COD_ESTUDIO; 

INSERT INTO FILMESESTUDIOS VALUES ('Filme teste','Universl');

SELECT * FROM FILMESESTUDIOS;

UPDATE FILMESESTUDIOS F SET F.TITULO  = 'Bastardos Iglórios' where F.TITULO = (select FI.TITULO from FILME FI where FI.COD_FILME=4);
UPDATE FILMESESTUDIOS F SET F.TITULO  = 'Fim da Escuridão' where F.TITULO like 'Fim%';
--OBS esses updates estão corretos?


-- Mostre a quantidade de filmes cadastrados para as categorias ‘Ação’ e ‘Aventura’. Calcule e mostre essas informações na projeção (cláusula SELECT).
--select com join
SELECT Count(F.COD_FILME) as Qtd_Filmes, C.DESCRICAO_CATEG as Descrição FROM FILME F 
join CATEGORIA C on C.COD_CATEG=F.COD_CATEG 
where C.DESCRICAO_CATEG='Ação' Group by C.DESCRICAO_CATEG;

--select com subconsulta
select Count(F.COD_FILME)as Qtd_Filmes FROM FILME F 
where F.COD_CATEG IN 
(select C.COD_CATEG from CATEGORIA C where C.DESCRICAO_CATEG='Ação' or C.DESCRICAO_CATEG='Aventura' ) 
Group By F.COD_CATEG ;
--Professora, como exibo a coluna da descrição da categoria na subcosulta?