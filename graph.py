from flask import Flask, render_template
from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.automap import automap_base

app = Flask(__name__)
engine = create_engine("mysql+mysqlconnector://root:root@localhost/felicidade?charset=utf8mb4")

DB = automap_base()
DB.prepare(autoload_with=engine)
Ocorrencias = DB.classes.tb_ocorrencia
TipoOcorrencia = DB.classes.tb_tipo_ocorrencia

session_factory = sessionmaker(bind=engine)
ses = session_factory()


@app.route("/")
def home():
    result = ses.query(TipoOcorrencia.tipo_ocorrencia_nome, func.count(Ocorrencias.id_ocorrencia).label('total')). \
        join(Ocorrencias, Ocorrencias.id_tipo_ocorrencia_fk == TipoOcorrencia.id_tipo_ocorrencia). \
        group_by(TipoOcorrencia.tipo_ocorrencia_nome).all()
    labels = [row.tipo_ocorrencia_nome for row in result]
    values = [row.total for row in result]

    return render_template("graph_bar.html", labels=labels, values=values)
