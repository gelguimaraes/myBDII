Create or replace procedure aumenta_salario2(d IN empregado.coddepto%type, percentual number) IS
Begin
Update empregado
Set salario = salario * (1 + percentual/100)
Where coddepto = d;
End;
SHOW ERRORS PROCEDURE aumenta_salario2;

exec aumenta_salario2(1,25);

SELECT * FROM EMPREGADO;

CREATE OR REPLACE PROCEDURE mostra_filmes (v_categoria IN categoria.descricao_categ%type) IS
cursor v_cursor_filme is select titulo, ano from filme f join categoria c on f.cod_categ = c.cod_categ
where descricao_categ = v_categoria;
c int;
BEGIN
    c:=0;
    FOR v_f IN v_cursor_filme LOOP
        dbms_output.put_line(c || '- Título: '|| v_f.titulo||  ', Ano: '|| v_f.ano);
        c:=c+1;
    END LOOP;
END;

SHOW ERRORS PROCEDURE mostra_filmes;

Exec mostra_filmes('Ação');


Create or replace function contafunc (d IN empregado.coddepto%type)
RETURN number IS 
total_func number;
Begin
    Select count(*) into total_func from empregado Where coddepto = d;
    Return total_func;
End;

SHOW ERRORS PROCEDURE contafunc;


Select contafunc(1) as "Total de Funcionarios" from dual;

declare x int;
begin
x:= contafunc(1);
dbms_output.put_line('Total de funcionarios: '|| x);
end;

Create or replace function DolarToReal(dolar in number, cotacao number)
Return number Is
Begin
    Return dolar * cotacao;
End;

declare v int;
begin
    v:= DolarToReal(100, 3.321);
    dbms_output.put_line('Valor em Dolar: '|| to_char(100));
    dbms_output.put_line('Valor em Real: '|| v);
end;
