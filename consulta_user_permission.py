from flask import Flask, render_template, request
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.automap import automap_base

app = Flask(__name__)

engine = create_engine("mysql+mysqlconnector://root:Gatitcha1!@localhost/teste?charset=utf8mb4")

DB = automap_base()
DB.prepare(autoload_with=engine)
ocorrencias = DB.classes.ocorrencias
user_table = DB.classes.user_table
ocorridos_relacionados = DB.classes.ocorridos_relacionados

session_factory = sessionmaker(bind=engine)
ses = session_factory()


def user_permissao(user):
    pessoa_permissao = ses.query(user_table).filter(user_table.nome.ilike(user))
    for c in pessoa_permissao:
        pessoa_permissao = c.permissao
        id = c.id
    return pessoa_permissao



#pre ...
def consultar_ocorrencias(permissao, id):
    if permissao:
        lst = ses.query(ocorrencias).join(ocorridos_relacionados, ocorrencias.id == ocorridos_relacionados.ocorrencias_id)
    else:
        lst = ses.query(ocorrencias).join(ocorridos_relacionados, ocorrencias.id == ocorridos_relacionados.ocorrencias_id).filter(ocorridos_relacionados.users_table_id == id)

    if lst.first():
        result_html = '<ul>'
        for obj in lst:
            result_html += f'<li><a href="#">{obj.local1}</a></li>'

        result_html += '</ul>'
        return result_html
    else:
        return "Uso não encontrado"



@app.route('/', methods=['GET', 'POST'])
def index():
    resultado = ""
    if request.method == 'POST':
        user = 'Usuário 2'
        resultado = consultar_ocorrencias(user[0], user[1])

    return render_template('Templatedic.html', resultado=resultado)

if __name__ == '__main__':
    app.run()
