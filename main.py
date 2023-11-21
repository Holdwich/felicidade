from flask import *
from ceub_flask.auth import auth

app = Flask(__name__)
app.register_blueprint(auth)

app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'


@app.route("/home")
def home():
    if "loggedin" in session and session['loggedin'] is True:
        return render_template("index.html")
    else:
        flash("O usuário precisa estar logado para acessar esta página.")
        return redirect(url_for("auth.login"))


if __name__ == "__main__":
    app.run(debug=True, use_reloader=True)
