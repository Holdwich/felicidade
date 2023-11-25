from flask import *
from flask import render_template, request, Flask
import re
from DAO import DAO
import hashlib

auth = Blueprint("auth", __name__, template_folder="templates")
app = Flask(__name__)

@auth.route("/login")
def login():
    return render_template("login.html")


@auth.route("/login", methods=["POST"])
def login_post():
    email = request.form.get("email")
    senha = hashlib.sha1(request.form.get("senha").encode('utf-8')).hexdigest()
    # checagem de login aqui
    
    bd = DAO("pessoa")

    checkCount = bd.checkLogin(email, senha)

    # se não logar...
    if checkCount == 0:
        flash("Senha ou Email incorretos, tente novamente!")
        return redirect(url_for("auth.login"))

    # se logar...

    session["loggedin"] = True
    session["id"] = DAO.selectFromWhere(bd, "pessoa_email", email, "pessoa_id_pessoa")[0][0]
    session["nome"] = DAO.selectFromWhere(bd, "pessoa_email", email, "pessoa_nome")[0][0]
    session["pessoa_permissao"] = DAO.selectFromWhere(bd, "pessoa_email", email, "pessoa_permissao")[0][0]
    session["email"] = email

    return redirect(url_for("home"))




'''@app.route("/Tempplatedic")
def index():
    resultado = consultar_ocorrencias(session["pessoa_permissao"], session['id'])

    return render_template('Templatedic.html', resultado=resultado)'''

@auth.route("/registro")
def registro():
    return render_template("CriarUser.html")


@auth.route("/registro", methods=['POST'])
def registro_post():
    email = request.form.get("email")
    senha = request.form.get("senha")
    confSenha = request.form.get("confirmaSenha")
    nome = request.form.get("nome")
    cpf = request.form.get("cpf")
    ra = request.form.get("numRegistro")
    telefone = request.form.get("telefone")
    dataNasc = request.form.get("dataNascimento")



    # check de existência
    bd = DAO("pessoa")

    checkCount = bd.selectCount("pessoa_email", email)
    checkRA = bd.selectCount("pessoa_RA", ra)
    checkCPF = bd.selectCount("pessoa_CPF", cpf)

    # se falhar...
    if checkCount >= 1:
        flash("Email já cadastrado!")
        return redirect(url_for("auth.registro"))
    elif checkRA >= 1:
        flash("RA já cadastrado!")
        return redirect(url_for("auth.registro"))
    elif checkCPF >= 1:
        flash("CPF já cadastrado!")
        return redirect(url_for("auth.registro"))
    elif not re.match(r"[^@]+@[^@]+\.[^@]+", email):
        flash("Email inválido!")
        return redirect(url_for("auth.registro"))
    elif not re.match(r"[A-Za-z]+", nome):
        flash("Nome deve conter apenas letras!")
        return redirect(url_for("auth.registro"))
    elif not confSenha or confSenha != senha:
        flash("Senhas não conferem!")
        return redirect(url_for("auth.registro"))
    elif not re.match(r"([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})",cpf,):
        flash("CPF inválido!")
        return redirect(url_for("auth.registro"))
    elif (
        not nome
        or not email
        or not senha
        or not confSenha
        or not cpf
        or not ra
        or not telefone
        or not dataNasc
    ):
        flash("Preencha o formulário todo!")
        return redirect(url_for("auth.registro"))

    # se não...
    else:
        # adicionar ao banco
        objBD = bd.pessoa()
        objBD.pessoa_email = email
        objBD.pessoa_senha = hashlib.sha1(senha.encode('utf-8')).hexdigest()
        objBD.pessoa_nome = nome
        objBD.pessoa_CPF = cpf
        objBD.pessoa_data_nasc = dataNasc
        objBD.pessoa_telefone = telefone
        objBD.pessoa_RA = ra
        objBD.pessoa_permissao = 0
        bd.create(objBD)
        print()
        bd.insert_tb_pessoa(cpf, nome, dataNasc, email, senha)

        flash("Cadastrado com sucesso!")
        return redirect(url_for("auth.login"))


@auth.route("/logout")
def logout():
    session.pop("loggedin", None)
    session.pop("id", None)
    session.pop("nome", None)
    session.pop("email", None)
    session.pop("pessoa_permissao", None)

    return redirect(url_for("index"))

@auth.route("/depoimento")
def depoimento():
    return render_template("Depoimento.html")

@auth.route("/depoimento", methods=['POST'])
def depoimento_post():
    bd = DAO("ocorrencia")
    objDB = bd.ocorrencia()

    ocorrencia_descricao = request.form.get("depoimento")
    id_tipo_ocorrencia_fk = request.form.get("id_tipo_ocorrencia_fk")
    id_sub_lugar_fk = request.form.get("id_sub_lugar_fk")
    id_pessoa_fk = session["id"]
    ocorrencia_status = 0
    ocorrencia_data_registro = date.today()
    ocorrencia_data = "não sei oq por"

    objDB.ocorrencia_descricao = ocorrencia_descricao
    objDB.id_tipo_ocorrencia_fk = id_tipo_ocorrencia_fk
    objDB.id_sub_lugar_fk = id_sub_lugar_fk
    objDB.id_pessoa_fk = id_pessoa_fk
    objDB.ocorrencia_status = ocorrencia_status
    objDB.ocorrencia_data_registro = ocorrencia_data_registro
    objDB.ocorrencia_data = ocorrencia_data
    bd.create(objDB)

    return redirect(url_for("home"))