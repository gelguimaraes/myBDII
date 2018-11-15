Declare nome varchar2(25);
Begin
 select nome_artista into nome from artista where cod_artista = 5;
 dbms_output.put_line ('Nome = '|| nome);
 Exception
    When no_data_found then dbms_output.put_line ('Nenhum artista com esse código foi encontrado');
End;

CREATE TABLE testa_bloco (coluna1 number, coluna2 date);

DECLARE
I INT := 0;
BEGIN
 WHILE I <= 10 LOOP
 INSERT INTO
 TESTA_BLOCO(coluna1,coluna2)
 VALUES (I,sysdate);
 I := I + 1;
 END LOOP;
END;

SELECT * FROM TESTA_BLOCO;



