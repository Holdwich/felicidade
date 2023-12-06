from flask import *
from auth import auth
from DAO import DAO
from datetime import date
from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.automap import automap_base
import openpyxl

app = Flask(__name__)
app.register_blueprint(auth)

app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'


@app.route("/home")
def home():
    if "loggedin" in session and session["loggedin"] is True:
        return render_template("Templatedic.html", nome=session["nome"].split()[0])
    else:
        flash("Logue para acessar esta página.")
        return redirect(url_for("auth.login"))


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/depoimento")
def depoimento():
    if "loggedin" in session and session["loggedin"] is True:
        return render_template("Depoimento.html")
    else:
        flash("Logue para acessar esta página.")
        return redirect(url_for("auth.login"))


@app.route("/depoimento", methods=["POST"])
def depoimento_post():
    bd = DAO("ocorrencia")
    objDB = bd.ocorrencia()

    ocorrencia_descricao = request.form.get("depoimento")
    id_tipo_ocorrencia_fk = request.form.get("id_tipo_ocorrencia_fk")
    id_sub_lugar_fk = request.form.get("id_sub_lugar_fk")
    id_pessoa_fk = session["id"]
    ocorrencia_status = 0
    ocorrencia_data_registro = date.today()
    ocorrencia_data = "PLACEHOLDER"

    objDB.ocorrencia_descricao = ocorrencia_descricao
    objDB.id_tipo_ocorrencia_fk = id_tipo_ocorrencia_fk
    objDB.id_sub_lugar_fk = id_sub_lugar_fk
    objDB.id_pessoa_fk = id_pessoa_fk
    objDB.ocorrencia_status = ocorrencia_status
    objDB.ocorrencia_data_registro = ocorrencia_data_registro
    objDB.ocorrencia_data = ocorrencia_data
    bd.create(objDB)

    flash("Ocorrência registrada com sucesso!")
    return redirect(url_for("home"))

@app.route("/estatisticas")
def estatisticas():

    Ocorrencias = DAO("ocorrencia")

    result = Ocorrencias.consultarEstatisticastipo()
    tipo_labels = [row.tipo_ocorrencia_nome for row in result]
    tipo_values = [row.total for row in result]

    lugar_result = Ocorrencias.consultarEstatisticaslugar()
    lugar_labels = [row.lugar_nome for row in lugar_result]
    lugar_values = [row.total for row in lugar_result]

    mes_result = Ocorrencias.consultarEstatisticasdata()
    mes_labels = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']
    mes_values = [row.total for row in mes_result]

    return render_template("graph_bar.html", tipo_labels=tipo_labels, lugar_labels=lugar_labels, mes_labels=mes_labels, tipo_values=tipo_values,lugar_values=lugar_values,mes_values=mes_values)

@app.route("/exportar_excel", methods=["POST"])
def exportar_excel():
    wb = openpyxl.Workbook()
    ws = wb.active
    Excel = DAO("ocorrencia")
    result = Excel.consultarOcorrencias()
    setor_list = [row.SETOR for row in result]
    tipo_ocorrencia_list = [row.TIPO_OCORRENCIA for row in result]
    pessoa_nome_list = [row.NOME for row in result]
    ocorrencia_descricao_list = [row.DESCRICAO for row in result]
    ocorrencia_data_list = [row.DATA_OCORRIDO for row in result]
    ocorrencia_data_registro_list = [row.DATA_REGISTRO for row in result]
    ocorrencia_status_list = [row.OCORRENCIA_STATUS for row in result]
    lugar_nome_list = [row.LOCAL for row in result]
    sublugar_nome_list = [row.SUB_LOCAL for row in result]
    headers = ["SETOR", "TIPO_OCORRENCIA", "NOME", "DESCRICAO", "DATA_OCORRIDO", "DATA_REGISTRO", "OCORRENCIA_STATUS", "LOCAL", "SUB_LOCAL"]
    for col_num, header in enumerate(headers, 1):
        ws.cell(row=1, column=col_num, value=header)
    for row_num, data in enumerate(zip(setor_list, tipo_ocorrencia_list, pessoa_nome_list, ocorrencia_descricao_list, 
                        ocorrencia_data_list, ocorrencia_data_registro_list, ocorrencia_status_list, lugar_nome_list, sublugar_nome_list), 2):
        for col_num, value in enumerate(data, 1):
            ws.cell(row=row_num, column=col_num, value=value)
    wb.save("Ocorrencias.xlsx")
    wb.close()

    return send_file("Ocorrencias.xlsx",as_attachment=True)

#rotas de erro
@app.errorhandler(404)
def page_not_found(error):
    return render_template('page_not_found.html')

@app.errorhandler(Exception)
def internal_server_error(error):
    return render_template('500_error.html')



if __name__ == "__main__":
    app.run(debug=True, use_reloader=True)
