alter table produto add quantidade number;
alter table produto add status varchar2(40);
update produto set quantidade = 10;


Create or replace procedure atualiza_status_estoque (cod in produto.codprod%type)
is 
qtd_atual  PRODUTO.QUANTIDADE%type;
Begin
    select quantidade into qtd_atual from produto where codprod = cod;
    if qtd_atual > 30 then
        update produto set status = 'Estoque dentro do esperado' where codprod = cod;
    else
        update produto set status = 'Estoque fora do limite minimo' where codprod = cod;
    end if;
    dbms_output.put_line('Status atualizado para o produto id: '|| cod);
    commit;
End;

Exec atualiza_status_estoque(11);


Create or replace procedure atualiza_status_estoque (cod in produto.codprod%type)
is 
qtd_atual  PRODUTO.QUANTIDADE%type;
status_atual  PRODUTO.STATUS%type;
Begin
    select quantidade into qtd_atual from produto where codprod = cod;
    if qtd_atual > 30 then
        update produto set status = 'Estoque dentro do esperado' where codprod = cod;
    else
        update produto set status = 'Estoque fora do limite minimo' where codprod = cod;
    end if;
     select status into status_atual from produto where codprod = cod;
    dbms_output.put_line('Status atualizado para '|| status_atual || ' do produto id: '|| cod);
    Exception
        When no_data_found then
           dbms_output.put_line('Nenhum produto com esse código foi encontrado');
        When too_many_rows then
            dbms_output.put_line('Muitos produtos com o mesmo codigo!!!');
    commit;
End;

Exec atualiza_status_estoque(10);

CREATE TABLE ALUNO (
 matriculaalu number not null,
 nome_alu varchar2(30),
 data_nasc date,
 curso varchar2(25),
 apelido varchar2(20),
 CONSTRAINT PK_ALU Primary key (Matriculaalu)
);

select * from Aluno;

create or replace procedure insAlu (
nome in aluno.nome_alu%type, 
nasc in aluno.data_nasc %type, 
curso in aluno. curso%type, 
apelido in aluno.apelido%type) 
is
mat aluno.matriculaalu%type; 
Begin
 SELECT NVL(MAX(matriculaalu), 2017000) + 1 INTO mat FROM aluno;
 insert into aluno (matriculaalu,  nome_alu, data_nasc, curso,  apelido) values(mat, nome, nasc, curso, apelido);
End;

exec insAlu('Aluno1', '11/11/2000', 'SI', 'apleido1');
exec insAlu('Aluno2', '22/12/2002', 'SI', 'apleido2');
exec insAlu('Aluno3', '01/01/2001', 'SI', 'apleido3');

CREATE OR REPLACE PROCEDURE dadosAlunos is
cursor dados_aluno
is select nome_alu, curso from aluno; 
begin
    for dados in dados_aluno loop
        dbms_output.put_line('Nome: '|| dados.nome_alu || ', Curso: ' || dados.curso);
    end loop;
End;

exec dadosAlunos;
 
--Faça um procedimento que mostre todos os artistas que estão associados a uma
--determinada categoria de filme (por exemplo, ‘Ação’). Passe a categoria como
--parâmetro e construa o cursor com base nela. Apresente o nome e o país de cada artista.
--Verifique sua execução. Teste, em seguida, com a categoria ‘Aventura’.

create or replace procedure mostraArtista (cat in categoria.descricao_categ%type) is
cursor select_art_pais is
select a.NOME_ARTISTA as Nome, a.PAIS as País from artista a 
join personagem p on p.COD_ARTISTA = a.cod_artista 
join Filme f on f.COD_FILME = p.COD_FILME 
join CATEGORIA c on f.COD_CATEG = c.COd_CATEG where c.DESCRICAO_CATEG = cat;

begin
    for v_row in select_art_pais loop
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_row.nome || ', Pais: ' || v_row.país);
    end loop;
    exception When no_data_found then
        DBMS_OUTPUT.PUT_LINE('Nenhum Artista encontrado nesta categoria: ' || cat);
    
end;

exec mostraArtista ('Ação');
exec mostraArtista ('Aventura');
exec mostraArtista ('Terror');
exec mostraArtista ('Drama');
exec mostraArtista ('Suspense');
commit;

create or replace function getDeptoSalario(dno number) 
return number is
sal_comp number;
Begin
    Sal_comp := 0;
    for func in (select salario from empregado where coddepto = dno and salario is not null) loop
        sal_comp := sal_comp + func.salario;
    end loop;
    return sal_comp;
end;

create or replace function getDeptoSalario(dno number) 
return number is
sal_comp number;
Begin
     select SUM(salario) into sal_comp from empregado where coddepto = dno and salario is not null;
    return sal_comp;
end;

declare sal number;
begin
    sal:= getDeptoSalario(1);
    dbms_output.put_line('Salario: '|| sal);
    
end;

create or replace function idade_artista (cod number) 
return number is
idade number; 
nasc date;
begin
    select data_nasc into nasc from artista where cod_artista= cod;
     idade := round((months_between(sysdate, nasc)/12));
     return idade;
end;

declare idade number;
begin
    idade:= idade_artista (5);
    dbms_output.put_line('Idade: '|| idade);  
end;


create or replace function media_idade_art 
return decimal is
cursor nascimentos is select data_nasc from artista;
media decimal; 
cont number; 
soma number;
begin
cont:=0;
soma:=0;
for datas in nascimentos loop
     soma := (EXTRACT(YEAR FROM sysdate) - EXTRACT(YEAR FROM datas.data_nasc)) + soma;
     cont := cont+1; 
    end loop;
    media := soma/cont;
    return media;
end;

create or replace function media_idade_art 
return real is
media real; 
begin
   select avg(round((months_between(sysdate, data_nasc)/12))) into media from artista;
  return media;
end;

declare media real;
begin
    media:= media_idade_art;
    dbms_output.put_line('Media das idades: '|| media);  
end;


CREATE TABLE Empregado2 
   (EMPLOYEE_ID NUMBER, 
    FIRST_NAME VARCHAR2(20), 
    LAST_NAME VARCHAR2(25) NOT NULL, 
    EMAIL VARCHAR2(25) NOT NULL, 
    PHONE_NUMBER VARCHAR2(20), 
    HIRE_DATE DATE NOT NULL, 
    JOB_ID VARCHAR2(10) NOT NULL, 
    SALARY NUMBER(8,2), 
    COMMISSION_PCT NUMBER(2,2), 
    MANAGER_ID NUMBER, 
    DEPARTMENT_ID NUMBER);

Create or Replace PROCEDURE calcula_bonus (emp_id IN NUMBER, bonus OUT REAL) IS
hiredate DATE;
bonus_exc EXCEPTION;
BEGIN
    SELECT salary * 0.10, hire_date INTO bonus, hiredate FROM empregado2 WHERE employee_id = emp_id;
    IF bonus IS NULL THEN
        RAISE bonus_exc;
    END IF;
    IF MONTHS_BETWEEN(SYSDATE, hiredate) > 30 THEN
        bonus := bonus + 500;
    END IF;
    EXCEPTION
        WHEN bonus_exc THEN dbms_output.put_line('bonus inexistente');
END calcula_bonus;

declare bonus real;
begin
    for cod in (select e.EMPLOYEE_ID from empregado2 e) loop
        calcula_bonus(cod.EMPLOYEE_ID , bonus);
        dbms_output.Put_line('Bonus ' || bonus);
    end loop;
end;
