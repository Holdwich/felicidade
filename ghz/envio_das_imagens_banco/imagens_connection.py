from mysql.connector import Error
from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.automap import automap_base


def insert_image(file_path, image_name):
    try:
        engine = create_engine("mysql+mysqlconnector://root:Gatitcha1@localhost/teste?charset=utf8mb4")

        DB = automap_base()
        DB.prepare(autoload_with=engine)
        tb_imagens = DB.classes.tb_midia
        session_factory = sessionmaker(bind=engine)
        ses = session_factory()
        max_id = ses.query(func.max(tb_imagens.id_midia)).scalar()
        obj = tb_imagens()
        image_name = image_name.replace('num', str(max_id + 1))

        with open(file_path, 'rb') as file:
            image_binario = file.read()

    except Error as e:
        print(f"erro: {e}")

    finally:
        obj.midia = image_binario
        ses.add(obj)
        # commit para salvar as alterações
        ses.commit()