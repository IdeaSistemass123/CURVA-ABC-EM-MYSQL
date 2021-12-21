
select
d2.codprod,d2.vlr,d2.qtd,perc ,d2.pracu,
case when d2.pracu <= 80 then 'A'
when d2.pracu <= 95 then 'B'
ELSE 'C' END CLASSE
from (
select
d1.codprod,d1.vlr,d1.qtd,d1.totalgeral,d1.perc,sum(perc) over(order by d1.perc desc) pracu
from(
select
d.codprod,d.qtd,
d.vlr, sum(d.vlr) over() totalgeral, cast(d.vlr  as decimal(15,2)) / cast(sum(d.vlr) over() as decimal(15,3)) *100 perc

from(

select i.codprod,sum(precototalcomdesc) as vlr,sum(quantidade) as qtd from iten_vendatemp
 AS I INNER JOIN PRODUTOS AS P ON ( P.CODPROD = I.CODPROD) inner join vendas as
 v on ( v.codigovenda = i.codvenda)
 inner join formadepagamento as f on(f.id = v.idformpag) where  I.situacao = 2
 and f.NAOTOTALIZARRELATORIOVENDAS = false group by codprod order by  vlr desc) d)d1)d2
