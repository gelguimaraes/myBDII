alter table produto add quantidade number;

alter table produto add status varchar2(40);
update produto set quantidade = 10;

Declare qtd_atual produto.quantidade%type;
Begin
 select quantidade into qtd_atual from produto
 where codprod = 11;
 if qtd_atual > 30 then
 update produto
 set status = 'Estoque dentro do esperado'
 where codprod = 11;
 else
 update produto
 set status = 'Estoque fora do limite minimo'
 where codprod = 11;
 end if;
 commit;
End;

Declare
 v_nome vendedor.nome%type;
 v_cod vendedor.codvend%type;
 v_faixa vendedor.faixacomissao%type;
Begin
 v_cod := 2;
 DBMS_OUTPUT.PUT_LINE('Codigo do Vendedor: '||v_cod);
 Select nome,faixacomissao into v_nome,v_faixa
 from vendedor
 where codvend = v_cod;
 DBMS_OUTPUT.PUT_LINE('Nome: '||v_nome);
 DBMS_OUTPUT.PUT_LINE('Faixa de Comissão: '||v_faixa);
 If v_faixa = 'A' Then
 DBMS_OUTPUT.PUT_LINE('Comissão de Alto nível');
 elsif v_faixa = 'B' then
 DBMS_OUTPUT.PUT_LINE('Comissão de Médio nível');
 else
 DBMS_OUTPUT.PUT_LINE('Faixa de Comissão crítica!');
 end if;
End;

DECLARE
 v_estudio estudio%ROWTYPE;
BEGIN
 SELECT cod_estudio, nome_estudio
 INTO v_estudio
 FROM estudio
 WHERE cod_estudio = 1;
 DBMS_OUTPUT.PUT_LINE('Estudio selecionado:'||v_estudio.nome_estudio);
END;


DECLARE
 novo_sal number(8,2);
 emp_id number := 2;
 emp_cargo varchar2(30);
 avg_sal number(8,2);
BEGIN
 SELECT cargo INTO emp_cargo
 FROM empregado
 WHERE matricula = emp_id;
 SELECT AVG(salario) INTO avg_sal
 FROM empregado
 WHERE cargo = emp_cargo;
 DBMS_OUTPUT.PUT_LINE ('O salário médio para ' || emp_cargo|| ' é ' || TO_CHAR(avg_sal));
 END; 

select nome_artista, cidade from artista where cod_artista = 1; --retorna um unico valor

select nome_artista, cidade from artista where pais = 'USA'; --retorna uma coleção

Declare
 v_nome vendedor.nome%type;
 v_salario vendedor.salariofixo%type;
CURSOR v_cursor_vendedor IS Select nome,salariofixo from vendedor;
Begin
     Open v_cursor_vendedor;
     LOOP
        fetch v_cursor_vendedor into v_nome,v_salario;
        EXIT when v_cursor_vendedor%NOTFOUND;
        dbms_output.put_line ('Nome: '|| v_nome || ' – ' || 'Salário: ' || v_salario);
     END LOOP;
     Close v_cursor_vendedor;
End;

Declare v_nome vendedor.nome%type;
 v_salario vendedor.salariofixo%type;
 CURSOR v_cursor_vendedor IS
 Select nome,salariofixo From vendedor;
Begin
 For v_vend IN v_cursor_vendedor LOOP
     v_nome := v_vend.nome;
     v_salario := v_vend.salariofixo;
     dbms_output.put_line ('Nome: '|| v_nome || ' – ' || 'Salário: ' || v_salario);
 End Loop;
End;

Declare
 qtd_atual produto.quantidade%type;
 v_cod produto.codprod%type;
 cursor p_cursor_prod is
 select codprod,quantidade from produto;
Begin
 open p_cursor_prod;
 loop
 fetch p_cursor_prod into v_cod,qtd_atual;
 if qtd_atual > 30 then
 update produto
 set status = 'Estoque dentro do esperado'
 where codprod = v_cod;
 else
 update produto
 set status = 'Estoque fora do limite mínimo'
 where codprod = v_cod;
 end if;
 exit when p_cursor_prod%notfound;
 end loop;
close p_cursor_prod;
End;


Declare
 --qtd_atual produto.quantidade%type;
 --v_cod produto.codprod%type;
    cursor cursor_prod is select codprod,quantidade from produto;
Begin
     for reg_cursor_prod in cursor_prod loop
         if reg_cursor_prod.quantidade >= 30 then
            update produto set status = 'Estoque dentro do esperado' where codprod = reg_cursor_prod.codprod;
         else
            update produto set status = 'Estoque fora do limite mínimo' where codprod = reg_cursor_prod.codprod;
         end if;
         exit when cursor_prod%notfound;
     end loop;
End;

select * from produto;

Declare
 faixa vendedor.faixacomissao%TYPE;
 Cursor c_vendedor(v_faixa vendedor.faixacomissao%TYPE)
is
 Select * From vendedor where faixacomissao = v_faixa;
Begin
 faixa := 'C';
        dbms_output.put_line ('Faixa: '|| faixa);
    For v_vend IN c_vendedor(faixa) LOOP
        dbms_output.put_line ('Vendedor: '|| v_vend.nome);
    End Loop;
End;

create table top as
 select a.cod_artista, nome_artista, cache
 from artista a join personagem p
 on a.cod_artista = p.cod_artista where 1 = 2;
 
 Begin
 For vart IN (Select a.cod_artista, nome_artista, cache
 FROM artista a join personagem p
 on a.cod_artista = p.cod_artista
 WHERE cache > 7000) LOOP
 Insert into top values
 (vart.cod_artista,vart.nome_artista, vart.cache);
 End loop;
End;

 Select * from top;

