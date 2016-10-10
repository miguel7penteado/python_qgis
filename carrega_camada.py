from PyQt4.QtSql import *

camada = iface.activeLayer()

minha_conexao = QgsDataSourceURI()
minha_conexao.setConnection("end_ip", "5432", "banco", "usuario", "senha")
minha_conexao.setDataSource("public", "nome_tabela", "coluna_geometria")

# Definindo camada

vcamada = QgsVectorLayer(minha_conexao.uri(), "setores", "postgres")

# carregando no qgis

QgsMapLayerRegistry.instance().addMapLayer(vcamada)

  
