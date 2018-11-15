
Declare nome varchar2(40);
BEGIN
    select nome_artista into nome from artista where cod_artista = 2;
    dbms_output.put_line('Quantidade de registros retornados = '||to_char(sql%ROWCOUNT));
    dbms_output.put_line('Nome do artista = '|| nome);
END;
--retorna 1 registro

DECLARE
    Depto_reg departamento%ROWTYPE;
BEGIN
    depto_reg.coddepto := 12;
    depto_reg.nome := 'Financeiro';
    depto_reg.local := 'Sede';
    DBMS_OUTPUT.PUT_LINE('depto_id: ' || depto_reg.coddepto);
    DBMS_OUTPUT.PUT_LINE('depto_nome: ' || depto_reg.nome);
    DBMS_OUTPUT.PUT_LINE('depto_local: ' || depto_reg.local);
END;
--rowtype serve para declarar o tipo com a mesma estrutura da tabela departamento no registro

alter table artista add indicacaooscar number;

BEGIN
    UPDATE artista SET indicacaooscar = 10 WHERE cod_artista = 100;
    IF SQL%NOTFOUND THEN
    INSERT INTO artista (cod_artista, nome_artista, indicacaooscar)
        VALUES (100, 'Wesley Snipes', 10);
    END IF;
END;
--insere uma linha caso o cod_artista nao seja encontrado. a saída não é visivel

create table testa_bloco (coluna1 number, coluna2 date);

DECLARE
    I INT := 1;
BEGIN
    WHILE I <= 10 LOOP
        IF(MOD(I,3)=0) THEN
            INSERT INTO TESTA_BLOCO(coluna1,coluna2) VALUES (I,sysdate);
            DBMS_OUTPUT.PUT_LINE('Linha inserida com valor do I: '|| I);
         END IF;   
        I := I + 1;
    END LOOP;
END;

SELECT * FROM TESTA_BLOCO;


Declare 
Numero CONSTANT NUMBER:= 5;
BEGIN
    FOR I IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(Numero || ' x ' || I || ' = ' || Numero*I);
    END LOOP;
END;
-- faz um loop com o numero e mostra uma tabela de multiplicacao

Declare 
Numero INT := 1;
BEGIN
    WHILE Numero < 10 LOOP
        FOR I IN 1..9 LOOP    
            DBMS_OUTPUT.PUT_LINE(Numero || ' x ' || I || ' = ' || Numero*I);
        END LOOP;
            DBMS_OUTPUT.PUT_LINE('...');
        Numero := Numero+1;
    END LOOP;
END;

Declare
    cursor film_cat is (select f.titulo as TITULO, c.descricao_categ as CATEGORIA
    from Filme f join categoria c on f.cod_categ = c.cod_categ 
    where c.descricao_categ='Ação');
begin

    for reg in film_cat loop
        dbms_output.put_line('Titulo: ' || reg.TITULO || ' na Categoria: ' || reg.CATEGORIA);
    end loop;
end;


Declare
    cursor v_cursor_TB is select coluna1,coluna2 from testa_bloco;
Begin
    for x in v_cursor_TB loop
        dbms_output.put_line(x.coluna1 || '-> ' || TO_CHAR(x.coluna2,'MM/DD/YYYY,HH:MI:SS'));
    end loop;
End;

Begin
    for x in (select coluna1,coluna2 from testa_bloco) loop
        dbms_output.put_line(x.coluna1 || '-> ' || TO_CHAR(x.coluna2,'MM/DD/YYYY,HH:MI:SS'));
    end loop;
End;



