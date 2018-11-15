--O que a seguinte consulta apresenta?
select titulo from filme where cod_estudio in 
(select cod_estudio from estudio where nome_estudio like 'P%');
--R: seleciona os filmes que possuem estudio come�ando com a letra P

-- Mostre as descri��es de categorias que est�o (associadas) na tabela Filme.
SELECT C.DESCRICAO_CATEG FROM CATEGORIA C WHERE C.COD_CATEG IN (SELECT F.COD_CATEG FROM FILME F);

-- Quem � o artista cujo nome de personagem � �Natalie�?
SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE A.COD_ARTISTA IN 
(SELECT P.COD_ARTISTA FROM PERSONAGEM P WHERE P.NOME_PERSONAGEM='Natalie' );

-- Existe algum artista cadastrado que n�o esteja na tabela Personagem?
SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE A.COD_ARTISTA NOT IN (SELECT P.COD_ARTISTA FROM PERSONAGEM P);
SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE NOT EXISTS (SELECT P.COD_ARTISTA FROM PERSONAGEM P WHERE P.COD_ARTISTA=A.COD_ARTISTA);

--Quais artistas est�o na tabela Personagem?

SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE A.COD_ARTISTA IN (SELECT P.COD_ARTISTA FROM PERSONAGEM P);
SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE EXISTS (SELECT P.COD_ARTISTA FROM PERSONAGEM P WHERE P.COD_ARTISTA=A.COD_ARTISTA);

--Qual a m�dia de caches existentes?
SELECT AVG(CACHE) as "M�dia dos Caches" FROM PERSONAGEM;

-- Mostre os nomes dos artistas que possuem cach� acima da m�dia.
SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE A.COD_ARTISTA IN (SELECT P.COD_ARTISTA FROM PERSONAGEM P WHERE P.CACHE > (SELECT AVG(CACHE)FROM PERSONAGEM));

--O que a consulta apresenta?
Select distinct descricao_categ
From categoria c join filme f on c.cod_categ = f.cod_categ
Where duracao > Any (Select max(duracao) From filme fi
group by fi.cod_categ);

--R: Mostra A descri��o das Categorias cujo os filmes tem dura��o maior que qualquer filme de sua categoria correspondente 
--OBS Coloquei o titulo para saber quais eram os filmes, mas pq Efeito Borboleta n�o aparece j� que ele tem a dura��o maior que os filmes de sua categoria?
--INSERT INTO FILME VALUES (8, 'Efeito Borboleta', '2006', 130, 6, 3);

Select max(duracao) From filme fi group by fi.cod_categ;

--Crie uma tabela que mostre os filmes (t�tulos) e seus est�dios (nomes). Insira um novo registro na tabela criada. Consulte a tabela.

CREATE TABLE filmesEstudios AS
select titulo, e.nome_estudio 
from filme f join estudio e on e.COD_ESTUDIO =
f.COD_ESTUDIO; 

INSERT INTO FILMESESTUDIOS VALUES ('Filme teste','Universl');

SELECT * FROM FILMESESTUDIOS;

UPDATE FILMESESTUDIOS F SET F.TITULO  = 'Bastardos Igl�rios' where F.TITULO = (select FI.TITULO from FILME FI where FI.COD_FILME=4);
UPDATE FILMESESTUDIOS F SET F.TITULO  = 'Fim da Escurid�o' where F.TITULO like 'Fim%';
--OBS esses updates est�o corretos?


-- Mostre a quantidade de filmes cadastrados para as categorias �A��o� e �Aventura�. Calcule e mostre essas informa��es na proje��o (cl�usula SELECT).
--select com join
SELECT Count(F.COD_FILME) as Qtd_Filmes, C.DESCRICAO_CATEG as Descri��o FROM FILME F 
join CATEGORIA C on C.COD_CATEG=F.COD_CATEG 
where C.DESCRICAO_CATEG='A��o' Group by C.DESCRICAO_CATEG;

--select com subconsulta
select Count(F.COD_FILME)as Qtd_Filmes FROM FILME F 
where F.COD_CATEG IN 
(select C.COD_CATEG from CATEGORIA C where C.DESCRICAO_CATEG='A��o' or C.DESCRICAO_CATEG='Aventura' ) 
Group By F.COD_CATEG ;
--Professora, como exibo a coluna da descri��o da categoria na subcosulta?