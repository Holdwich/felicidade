from mysql.connector import connect
from mysql.connector import Error

def insert_image(file_path, image_name):
    try:
        connection = connect(
            host='localhost',
            database='teste',
            user='root',
            password='Gatitcha1'
        )

        if connection.is_connected():
            cursor = connection.cursor()

            # le a imagem em formato de binario
            with open(file_path, 'rb') as file:
                image_binario = file.read()

            # inserir a imagem no banco
            query = "INSERT INTO tabela_imagens (nome, imagem) VALUES (%s, %s)"
            values = (image_name, image_binario)
            cursor.execute(query, values)

            # commit para salvar as alterações
            connection.commit()

            print("Imagem inserida com sucesso!")

    except Error as e:
        print(f"Erro: {e}")

    finally:
        # fechar a conexão
        if connection.is_connected():
            cursor.close()
            connection.close()


