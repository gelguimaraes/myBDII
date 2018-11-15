GRANT create view to Gesoaldo;
GRANt create role to Gesoaldo

GRANt create role to public;

GRANT Select ON Produto TO user_teste;

GRANT All privileges ON Cliente TO public;

GRANT all on pedido to Gesoaldo WITH GRANT OPTION;

GRANT update(valor) on produto to user_teste

Revoke select on produto from user_teste;


create Role prodsis; -- cria o papel

Grant all on cliente to prodsis; -- concede privilegio ao papel
Grant all on produto to prodsis;
Grant all on pedido to prodsis;

Grant prodsis to user_teste, Gesoaldo --concede os privilegios para os usuario pelo papel


create table Empregado (
Matricula number,
PrimeiroNome varchar2(15),
Sobrenome varchar2(15),
Dataadmissao date,
Cargo varchar2(30),
Salario number(13,2),
gerente number,
CodDepto number);
alter table empregado add constraint pkemp primary key(matricula);


create table Departamento (
CodDepto number,
Nome varchar2(20),
Local varchar2(20));
alter table departamento add constraint pkdepto primary key(coddepto);


CREATE or replace VIEW EmpDepto AS
SELECT e.primeironome, d.nome
FROM empregado e join departamento d on e.coddepto = d.coddepto;

Grant select on empdepto to user_teste

