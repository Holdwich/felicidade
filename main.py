from flask import *
from auth import auth
from DAO import DAO
from datetime import date

app = Flask(__name__)
app.register_blueprint(auth)

app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'


@app.route("/home")
def home():
    if "loggedin" in session and session["loggedin"] is True:
        return render_template("Templatedic.html", nome=session["nome"])
    else:
        flash("O usuário precisa estar logado para acessar esta página.")
        return redirect(url_for("auth.login"))


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/depoimento")
def depoimento():
    if "loggedin" in session and session["loggedin"] is True:
        return render_template("Depoimento.html")
    else:
        flash("O usuário precisa estar logado para acessar esta página.")
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


if __name__ == "__main__":
    app.run(debug=True, use_reloader=True)
