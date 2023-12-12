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
    senha = hashlib.sha1(request.form.get("senha").encode("utf-8")).hexdigest()
    bd = DAO("pessoa")

    checkCount = bd.checkLogin(email, senha)

    # se não logar...
    if checkCount == 0:
        flash("Senha e/ou Email incorretos")
        return redirect(url_for("auth.login"))

    # se logar...

    session["loggedin"] = True
    session["id"] = DAO.selectFromWhere(bd, "pessoa_email", email, "pessoa_id_pessoa")[0][0]
    session["nome"] = DAO.selectFromWhere(bd, "pessoa_email", email, "pessoa_nome")[0][0]
    session["pessoa_permissao"] = DAO.selectFromWhere(bd, "pessoa_email", email, "pessoa_permissao")[0][0]
    session["email"] = email

    return redirect(url_for("home"))


@auth.route("/registro")
def registro():
    return render_template("CriarUser.html")


@auth.route("/ocorrencias_lista")
def ocorrencias_lista():
    bd = DAO("ocorrencia")

    if session['pessoa_permissao']:
        lst = bd.readAll()
    else:
        lst = bd.selectFromWhere("id_pessoa_fk", session['id'])
    result_html = '<tbody>'
    for obj in lst:
        result_html += '<tr>'
        result_html += f'<td>{obj.id_tipo_ocorrencia_fk}</td><td>{obj.id_sub_lugar_fk}</td><td>{session["email"]}</td><td>{obj.ocorrencia_data_registro}</td><td>{session["nome"]}</td>'
        result_html += '</tr>'
    result_html += '</tbody>'
    return render_template("fun.html", result_html=result_html, nome=session['nome'].split()[0])


@auth.route("/registro", methods=["POST"])
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
    elif not re.match(
            r"([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})",
            cpf,
    ):
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
        objBD.pessoa_senha = hashlib.sha1(senha.encode("utf-8")).hexdigest()
        objBD.pessoa_nome = nome
        objBD.pessoa_CPF = cpf
        objBD.pessoa_data_nasc = dataNasc
        objBD.pessoa_telefone = telefone
        objBD.pessoa_RA = ra
        objBD.pessoa_permissao = 0
        bd.create(objBD)

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
