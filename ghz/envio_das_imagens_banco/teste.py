from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.automap import automap_base

engine = create_engine("mysql+mysqlconnector://root:Gatitcha1@localhost/teste?charset=utf8mb4")

DB = automap_base()
DB.prepare(autoload_with=engine)
tb_imagens = DB.classes.tabela_imagens
session_factory = sessionmaker(bind=engine)
ses = session_factory()


# Consulta para obter o máximo ID
max_id_query = ses.query(func.max(tb_imagens.id)).scalar()


# Fechando a sessão
ses.close()

print(max_id_query)