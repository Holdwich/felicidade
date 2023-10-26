from flask import *
import re

auth = Blueprint("auth", __name__, template_folder="templates")


@auth.route("/login")
def login():
    return render_template("login.html")


@auth.route("/login", methods=["POST"])
def login_post():
    email = request.form.get("email")
    senha = request.form.get("senha")

    # checagem de login aqui

    # se não logar...
    if ...:
        flash("Senha ou Email incorretos, tente novamente!")
        return redirect(url_for("auth.login"))

    # se logar...

    session["loggedin"] = True
    session["id"] = cursor["id"]
    session["nome"] = cursor["nome"]
    session["email"] = cursor["email"]

    return redirect(url_for("main.home"))


@auth.route("/login/registro")
def registro():
    return render_template("registro.html")


@auth.route("/login/registro", methods=["POST"])
def registro_post():
    email = request.form.get("email")
    senha = request.form.get("senha")
    nome = request.form.get("nome")

    # check de existência

    # se falhar...
    if ...:
        flash("Email já cadastrado")
        return redirect(url_for("auth.registro"))
    elif not re.match(r"[^@]+@[^@]+\.[^@]+", email):
        flash("Email inválido!")
        return redirect(url_for("auth.registro"))
    elif not re.match(r"[A-Za-z]+", nome):
        flash("Nome deve conter apenas letras!")
        return redirect(url_for("auth.registro"))
    elif not nome or not email or not senha:
        flash("Preencha o formulário todo!")
        return redirect(url_for("auth.registro"))

    # se não...
    else:
        # adicionar ao banco

        flash("Cadastrado com sucesso!")
        return redirect(url_for("auth.login"))


@auth.route("/logout")
def logout():
    session.pop("loggedin", None)
    session.pop("id", None)
    session.pop("nome", None)
    session.pop("email", None)

    return redirect(url_for("auth.login"))
