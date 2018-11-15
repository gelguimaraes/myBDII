Select descricao
From produto
Where unidade IN ('KG', 'L', 'M');

Select avg(valor) From produto; 

select descricao
From produto
Where codprod in (select codprod
 From itenspedido
Where quantidade = 10);

select codprod
 From itenspedido
Where quantidade = 10;

select nome
From vendedor
Where salariofixo > (select AVG(salariofixo)
 From vendedor);

select AVG(salariofixo)
 From vendedor;
 
 Select descricao
From produto
Where valor >=
 ANY (Select max(valor)
 From produto
 group by unidade);
 
 Select unidade, max(valor)
 From produto
 group by unidade;
 
Select descricao
From produto
Where valor >=
 ALL (Select max(valor)
 From produto
 group by unidade);
 
 
 select codprod, descricao
From produto P
Where not exists (select * From itenspedido
Where codprod = P.codprod);

 select codprod, descricao
From produto P
Where exists (select * From itenspedido
Where codprod = P.codprod);

SELECT * FROM PRODUTO;

CREATE TABLE filmesAventura AS
select cod_filme,titulo
from filme f join categoria c on f.cod_categ =
c.cod_categ
where c.descricao_categ = 'Aventura'; 
 
 
SELECT * FROM FILMESAVENTURA;

insert into filmesAventura values(2,'Batman');
 
 
 create table estudio1 as
 select * from estudio where 1=2; --cria a tabela apenas com a estrutura
 
 SELECT * FROM ESTUDIO1;

 Select distinct 
 (Select COUNT(*) from cliente where cidade like 'João Pessoa') AS Pessoenses, 
 (Select COUNT(*) from cliente where cidade like 'Recife') AS Recifenses 
 From cliente;
 
 insert into cliente (codcli,nome) (select codvend + 10, nome from vendedor where faixacomissao like 'A');
 
 SELECT * FROM CLIENTE;
 
 SELECT * FROM VENDEDOR; 
 
 SELECT * FROM PRODUTO; 
 
 Update produto Set valor = valor*1.025 Where valor < (select avg(valor) From produto Where unidade = 'KG');
 
 insert into pedido values(100,10,'12/10/2009',4,null);

SELECT * FROM PEDIDO;

delete from pedido P where not exists (select nome from vendedor where codvend = P.codvend);

Select p.data from pedido p where p.numped in
 (select i.numped from itenspedido i where i.codprod in
 (select pr.codprod from produto pr where descricao like 'Chocolate')); --select com subconsulta
 
 select P.DATA from PEDIDO P 
 join ITENSPEDIDO I on P.NUMPED = I.NUMPED 
 join PRODUTO PR ON PR.CODPROD = I.CODPROD 
 where PR.DESCRICAO like 'Chocolate'; --select com join
 
SELECT nome, codcli FROM cliente WHERE codcli NOT IN
(SELECT codcli FROM pedido)
ORDER BY nome;

Select nome, c.codcli from cliente c left join pedido p on c.codcli =
p.codcli where p.codcli is null
Order by nome;
 
Select nome, c.codcli as cliente, p.codcli as ClienteemPedido, numped
from cliente c left join pedido p on c.codcli = p.codcli
Order by nome;

select titulo from filme where cod_estudio in (select cod_estudio from estudio where nome_estudio like 'P%'); 

SELECT * FROM ESTUDIO;
SELECT * FROM Filme;
SELECT * FROM CATEGORIA; 
SELECT * FROM PERSONAGEM;
SELECT * FROM ARTISTA;


UPDATE FILME F SET F.TITULO  = 'Bastardos Iglórios' where F.COD_FILME=4;
UPDATE FILME F SET F.TITULO  = 'Fim da Escuridão' where F.COD_FILME=6;

UPDATE CATEGORIA C SET C.DESCRICAO_CATEG = 'Comédia' where C.COD_CATEG = 3;
UPDATE CATEGORIA C SET C.DESCRICAO_CATEG = 'Ação' where C.COD_CATEG = 4;

UPDATE ARTISTA A SET A.NOME_ARTISTA = 'Raul Júlia' where A.NOME_ARTISTA like 'Raul%';


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
SELECT AVG(CACHE) as "Média dos Caches" FROM PERSONAGEM;

-- Mostre os nomes dos artistas que possuem cach� acima da m�dia.
SELECT A.NOME_ARTISTA FROM ARTISTA A WHERE A.COD_ARTISTA IN (SELECT P.COD_ARTISTA FROM PERSONAGEM P WHERE P.CACHE > (SELECT AVG(CACHE)FROM PERSONAGEM));

--O que a consulta apresenta?
Select distinct descricao_categ, f.titulo
From categoria c join filme f on c.cod_categ = f.cod_categ
Where duracao > Any (Select max(duracao) From filme fi
group by fi.cod_categ);
--R: Mostra A descri��o das Categorias cujo os filmes tem dura��o maior que qualquer filme de sua categoria correspondente 
--OBS Coloquei o titulo para saber quais eram os filmes, mas pq Efeito Borboleta n�o aparece j� que ele tem a dura��o maior que os filmes de sua categoria?


Select max(duracao) From filme fi group by fi.cod_categ;

--Crie uma tabela que mostre os filmes (t�tulos) e seus est�dios (nomes). Insira um novo registro na tabela criada. Consulte a tabela.

CREATE TABLE filmesEstudios AS
select titulo, e.nome_estudio 
from filme f join estudio e on e.COD_ESTUDIO =
f.COD_ESTUDIO; 

INSERT INTO FILMESESTUDIOS VALUES ('Filme teste','Universl');

SELECT * FROM FILMESESTUDIOS;

UPDATE FILMESESTUDIOS F SET F.TITULO  = 'Bastardos Iglórios' where F.TITULO = (select FI.TITULO from FILME FI where FI.COD_FILME=4);
UPDATE FILMESESTUDIOS F SET F.TITULO  = 'Fim da Escuridão' where F.TITULO like 'Fim%';
--OBS esses updates est�o corretos?


-- Mostre a quantidade de filmes cadastrados para as categorias �A��o� e �Aventura�. Calcule e mostre essas informa��es na proje��o (cl�usula SELECT).
--select com join
SELECT Count(F.COD_FILME) as Qtd_Filmes, C.DESCRICAO_CATEG as Descri��o FROM FILME F 
join CATEGORIA C on C.COD_CATEG=F.COD_CATEG 
where C.DESCRICAO_CATEG='Ação' or C.DESCRICAO_CATEG='Aventura' Group by C.DESCRICAO_CATEG;

--select com subconsulta
select Count(F.COD_FILME)as Qtd_Filmes, F.COD_CATEG FROM FILME F 
where F.COD_CATEG IN 
(select C.COD_CATEG from CATEGORIA C where C.DESCRICAO_CATEG='Ação' or C.DESCRICAO_CATEG='Aventura' ) 
Group By F.COD_CATEG ;
--Professora, como exibo a coluna da descri��o da categoria na subcosulta?


