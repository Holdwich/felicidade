from mysql.connector import connect, Error

# Conectar ao banco de dados
try:
    connection = connect(
        host='localhost',
        database='teste',
        user='root',
        password='Gatitcha1'
    )

    if connection.is_connected():
        cursor = connection.cursor()

        # Executar a consulta SQL para obter o valor máximo da coluna ID na tabela tabela_imagens
        cursor.execute("SELECT MAX(id) FROM tabela_imagens")
        result = cursor.fetchone()
        max_id = result[0] if result[0] is not None else 0

        # Imprimir o valor máximo obtido
        print(f'O valor máximo da coluna ID é: {max_id + 1}')

except Error as e:
    print(f"Erro: {e}")

finally:
    # Fechar a conexão
    if connection.is_connected():
        cursor.close()
        connection.close()
