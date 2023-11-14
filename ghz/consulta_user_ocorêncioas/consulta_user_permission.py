from flask import Flask, render_template, request
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.automap import automap_base
from prettytable import PrettyTable

app = Flask(__name__)

engine = create_engine("mysql+mysqlconnector://root:Gatitcha1@localhost/teste?charset=utf8mb4")

DB = automap_base()
DB.prepare(autoload_with=engine)
ocorrencias = DB.classes.ocorrencias
user_table = DB.classes.user_table
ocorridos_relacionados = DB.classes.ocorridos_relacionados

session_factory = sessionmaker(bind=engine)
ses = session_factory()


def user_permissao(user):
    permissao = ses.query(user_table).filter(user_table.nome.ilike(user))
    for c in permissao:
        permissao = c.permissao
        id = c.id
    return permissao, id

def consultar(permissao, id):
    pt = PrettyTable(["Identificador", "Uso"])
    if permissao:
        lst = ses.query(ocorrencias).join(ocorridos_relacionados, ocorrencias.id == ocorridos_relacionados.ocorrencias_id)
    else:
        lst = ses.query(ocorrencias).join(ocorridos_relacionados, ocorrencias.id == ocorridos_relacionados.ocorrencias_id).filter(ocorridos_relacionados.users_table_id == id)
    if lst.first():
        for obj in lst:
            pt.add_row([obj.id, obj.local1])
        return pt.get_html_string()
    else:
        return "Uso não encontrado"



@app.route('/', methods=['GET', 'POST'])
def index():
    resultado = ""
    if request.method == 'POST':
        user = user_permissao(request.form['nome'])
        resultado = consultar(user[0], user[1])

    return render_template('index.html', resultado=resultado)

if __name__ == '__main__':
    app.run()
