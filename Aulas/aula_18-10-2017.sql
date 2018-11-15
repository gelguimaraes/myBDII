INSERT INTO departamento VALUES (6, 'Marketing', 'Centro');
INSERT INTO departamento VALUES (7, 'Vendas', 'Centro');
INSERT INTO departamento VALUES (8, 'Financeiro', 'Centro');

SELECT * FROM DEPARTAMENTO;

COMMIT;

SELECT * FROM DEPARTAMENTO;

INSERT INTO departamento VALUES (9, 'Treinamento', 'Centro');
INSERT INTO departamento VALUES (10, 'Financeiro', 'Centro');
SELECT * FROM departamento;
ROLLBACK;
SELECT * FROM departamento;

grant all on artista to Joao

SELECT * FROM JOAO.ARTISTA;

Insert into Joao.artista(cod_artista, nome_artista) values (5678,'Glória Pires');
Insert into Joao.artista(cod_artista,nome_artista) values (5078,'Fernanda Montenegro');

COMMIT WORK;

INSERT INTO JOAO.ARTISTA(COD_ARTISTA, NOME_ARTISTA) VALUES (100, 'José Maria');

ROLLBACK;




