
--questao 1
create table Mae (
 cod number,
 nome varchar2(10),
 CONSTRAINT PK_MAE primary key(cod)
)

create table Filha (
 cod number,
 nome varchar2(10),
 cod_mae number,
 CONSTRAINT fk_mae FOREIGN KEY(cod_mae) REFERENCES Mae(cod)
)

insert into Mae (cod, nome) values ('1', 'Maria');
insert into Mae (cod, nome) values ('2', 'Joana');
insert into Filha (cod, nome, cod_mae) values ('1', 'Luana', '1');
insert into Filha (cod, nome, cod_mae) values ('2', 'Luciana', '2');

create or replace trigger atualiza_mae
after update of cod on Mae
for each row
begin
    update Filha set cod_mae = :new.cod  where cod_mae = :old.cod;
end;

update mae set cod = 300 where cod = 30;
update mae set cod = 25 where cod = 2;

select * from mae;
select * from filha;
 
--questao 2
create or replace view filmcat2 (titulo, ano, categoria) 
AS 
Select titulo, ano, descricao_categ from filme f join categoria c on c.cod_categ = f.cod_categ;


create or replace trigger insFilmeView2 
Instead of insert on filmcat2
Declare codCat number;
codFilme number;
Begin
    SELECT NVL(MAX(cod_filme),0)+1 INTO codFilme FROM filme;
    Select cod_categ into codCat from categoria c where c.descricao_categ = :new.categoria ;
    insert into filme f(f.cod_filme, f.titulo, f.ano, f.cod_categ) values (codFilme, :new.titulo, :new.ano, codCat);
    
    exception When no_data_found then
        SELECT NVL(MAX(cod_categ),0)+1 INTO codCat FROM categoria;
        insert into categoria c(c.cod_categ, c.descricao_categ) values (codCat, :new.categoria);
        insert into filme f(f.cod_filme, f.titulo, f.ano, f.cod_categ) values (codFilme, :new.titulo, :new.ano, codCat);
End;

insert into filmcat2 values ('Liga da Justiça',2017,'Aventura');
insert into filmcat2 values('IT',2017,'TesteTerror');

commit;
select * from filmcat2;

--questao3
Create table Esporte (
    cod_esp NUMBER NOT NULL,
    desc_esp VARCHAR2(25));
Create table Atleta (
    cod_atleta NUMBER NOT NULL,
    Nome_atleta VARCHAR2(25),
    data_nasc DATE,
    bolsa NUMBER (12,2),
    esporte NUMBER);
alter table esporte add constraint pk_esp primary key(cod_esp);
alter table atleta add constraint pk_atleta primary key(cod_atleta);
alter table atleta add constraint fk_atl_esp foreign key(esporte) references esporte;


insert into Esporte (cod_esp, desc_esp) values ('1','Futebol');
insert into Esporte (cod_esp, desc_esp) values ('2','Natação');
insert into Esporte (cod_esp, desc_esp) values ('3','Volei');


insert into Atleta (cod_atleta, Nome_atleta, data_nasc, bolsa,  esporte) values ('1','Mario','01/12/2000','2300','1');
insert into Atleta (cod_atleta, Nome_atleta, data_nasc, bolsa,  esporte) values ('2','Jose','05/12/2001','3000','2');
insert into Atleta (cod_atleta, Nome_atleta, data_nasc, bolsa,  esporte) values ('3','Joao','20/10/2002','2000','1');
insert into Atleta (cod_atleta, Nome_atleta, data_nasc, bolsa,  esporte) values ('4','Pedro','07/07/2003','4000','3');
insert into Atleta (cod_atleta, Nome_atleta, data_nasc, bolsa,  esporte) values ('5','Renato','03/02/2005','2500','1');
insert into Atleta (cod_atleta, Nome_atleta, data_nasc, bolsa,  esporte) values ('6','Lucas','11/12/2002','2700','2');


--questao 4
--Crie uma procedure armazenada que atualize as bolsas dos atletas de acordo com um
--percentual passado como parâmetro. Para isso a bolsa atual deve ser menor que a
--média de todas as bolsas. Use um cursor contendo todos os atletas. Faça emitir
--mensagem (dbms_output) apresentando, para cada atleta, o nome do atleta, valor da
--bolsa, da média das bolsas e status (atualizado, não atualizado) (vale 0,2).

create or replace procedure bolsa (percentual in number)
is cursor cursor_atletas 
is select Nome_atleta, data_nasc, bolsa from Atleta;
media_bolsas number;
status varchar2(30);
begin
  Select avg(bolsa) into media_bolsas from Atleta;
  for v_atleta in cursor_atletas loop
    if v_atleta.bolsa < media_bolsas then
        update Atleta set bolsa = v_atleta.bolsa * (1+percentual/100) ; 
        status := 'Atualizado';
    else
        status:= 'Não Atualizado';
    end if;
    dbms_output.put_line('Nome: '|| v_atleta.nome_atleta || ', Bolsa: ' || v_atleta.bolsa || ', Media das Bolsas: ' || media_bolsas || ', Status: ' || status);
    end loop;
end;

exec bolsa(25);

create or replace function qtd_atletas (nome in  esporte.desc_esp%type)
return number is
qtd number;
begin
    select Count(desc_esp) as Qtd into qtd from atleta a join esporte e on a.esporte = e.cod_esp where e.desc_esp = nome group by e.desc_esp;
        return qtd;
    exception When no_data_found then
        return 0;
end;

declare qtd number;
begin
    qtd := qtd_atletas('Futebol');
    --qtd := qtd_atletas('Atletismo');
    dbms_output.put_line('Quantidade de Atletas: '|| qtd); 
end;

