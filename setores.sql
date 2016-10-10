drop table if exists aracatuba.setores_atual; 

-- Query no. 3 - Da filtragem, ela extrai apenas a feição de data relevante, exporta o filtrado como camada para um "diretorio da agencia", para análise espacial
SELECT
(
	SUBSTRING(c.cd_geocodi,1,2) || -- DF
	'-' || 
	SUBSTRING(c.cd_geocodi,3,5) || -- Municipio
	'-' || 
	SUBSTRING(c.cd_geocodi,8,2) || -- Distrito
	'-' || 
	SUBSTRING(c.cd_geocodi,10,2) || -- SubDistrito
	'-' || 
	SUBSTRING(c.cd_geocodi,12,4) -- Setor
) as geocodigo,
c.feicoes_duplicadas, c.geom, c.cd_geocodi, c.data_impor, c.hora_impor, c.usuario, c.maquina, c.municipio, c.agencia, setor_id
into aracatuba.setores_atual
from
(SELECT DISTINCT ON (a.cd_geocodi) b.feicoes_duplicadas, a.cd_geocodi, a.data_impor, a.hora_impor, a.usuario, a.maquina, a.municipio, a.agencia, a.geom, a.setor_id
from (
	-- Query 1 - Ordenar, Criar Máscara, Criar um indice numerico futuro , filtrando qual agencia quero trabalhar
	select CAST(coalesce(cd_geocodi, '0') AS bigint ) as setor_id,
	geom, cd_geocodi, data_impor, hora_impor, usuario, maquina, municipio, agencia 
	from public.setores
	WHERE agencia='ARACATUBA'
	group by cd_geocodi, data_impor, hora_impor, usuario, maquina, agencia 
	order by setor_id, data_impor, hora_impor
	ASC
     ) as a 
join -- não é query, mas é pareamento de 2 consultas
     (
	-- Query no. 2 - Contagem de feições duplicadas
	SELECT cd_geocodi, count(*) AS feicoes_duplicadas FROM public.setores
	GROUP BY 1 
	ORDER BY cd_geocodi
     ) as b 
ON a.cd_geocodi = b.cd_geocodi) as c;

alter table aracatuba.setores_atual add constraint "pk_araca_atual" primary key (cd_geocodi,data_impor, hora_impor, usuario, maquina, municipio, agencia );


