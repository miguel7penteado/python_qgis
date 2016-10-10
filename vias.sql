drop table if exists aracatuba.vias_atual; 

-- Query no. 3 - Da filtragem, ela extrai apenas a feição de data relevante, exporta o filtrado como camada para um "diretorio da agencia", para análise espacial
SELECT

c.cd_geo, c.cd_setor, c.cd_quadra, c.cd_face, c.nm_txtmemo, c.cd_layer, c.cd_seq_log, c.cd_seq_qfa, c.id, 
c.tp_insumo_, c.cd_cep, c.nm_localid, c.nm_tipo_lo, c.nm_titulo_, c.nm_nome_lo, c.sit_pre_co, c.origem, 
c.gm_linha_s, c.data_base, c.geom, c.data_impor, c.hora_impor, c.data_final 
INTO aracatuba.vias_atual
from
(
SELECT DISTINCT ON (a.cd_geo) b.feicoes_duplicadas,
a.cd_geo, a.cd_setor, a.cd_quadra, a.cd_face, a.nm_txtmemo, a.cd_layer, a.cd_seq_log,a.cd_seq_qfa, a.id, a.tp_insumo_, a.cd_cep, a.nm_localid, a.nm_tipo_lo, a.nm_titulo_, 
a.nm_nome_lo, a.sit_pre_co, a.origem, a.gm_linha_s, 
a.data_base, a.geom,a.data_impor, a.hora_impor, a.data_final, a.usuario, a.maquina, a.municipio, a.agencia,
a.setor_id, a.quadra_id, a.face_id
from (
	-- Query 1 - Ordenar, Criar Máscara, Criar um indice numerico futuro , filtrando qual agencia quero trabalhar
	SELECT
	CAST(coalesce(cd_setor, '0') AS bigint ) as setor_id ,
	CAST(coalesce(cd_quadra, '0') AS int ) as quadra_id,
	CAST(coalesce(cd_face, '0') AS int ) as face_id,
        cd_geo, cd_setor, cd_quadra, cd_face, nm_txtmemo, cd_layer, cd_seq_log, cd_seq_qfa,  id,  tp_insumo_,  cd_cep,  
        nm_localid,  nm_tipo_lo,  nm_titulo_, nm_nome_lo,  sit_pre_co,  origem,  gm_linha_s,  
        data_base, data_impor,  hora_impor,  data_final, usuario, maquina, municipio, agencia, geom
	from public.vias
	WHERE agencia='ARACATUBA'
	group by cd_setor, cd_quadra, cd_face data_impor, hora_impor, usuario, maquina, agencia 
	order by setor_id, quadra_id,face_id, data_impor, hora_impor
	ASC
     ) as a 
join -- não é query, mas é pareamento de 2 consultas
     (
	-- Query no. 2 - Contagem de feições duplicadas
	SELECT cd_geo, count(*) AS feicoes_duplicadas FROM public.vias
	GROUP BY 1 
	ORDER BY cd_geo
     ) as b 
ON a.cd_geo = b.cd_geo) as c;

alter table aracatuba.vias_atual add constraint "pk_araca_atual" primary key (cd_geo,data_impor, hora_impor, usuario, maquina, municipio, agencia );



