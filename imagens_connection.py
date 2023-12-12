from mysql.connector import Error
from DAO import DAO
def insert_image(file_path, image_name):
    try:
        bd = DAO("midia")
        max_id = bd.get_max_id()
        image_name = image_name.replace('num', str(max_id + 1))

        with open(file_path, 'rb') as file:
            image_binario = file.read()

    except Error as e:
        print(f"erro: {e}")

    finally:
        bd2 = DAO("ocorrencia")
        bd = DAO("midia")
        objBD = bd.midia()
        objBD.id_ocorrencia_fk = bd.get_max_id()
        objBD.midia_descricao = image_name
        objBD.midia = image_binario
        bd.create(objBD)
