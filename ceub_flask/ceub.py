from flask import Flask, render_template , request
# from util import bd
app = Flask(__name__)
@app.route('/')
def login_form():
  return render_template('login.html')

@app.route('/pass', methods=['GET'])
def process_login():
  user = request.args.get('user').lower()
  senha = request.args.get('senha')
  print(user,senha)
  # Faça o processamento necessário com os valores recebidos
  # Neste exemplo, vamos apenas retornar os valores dentro de uma função
  if (user == 'amelia' and senha == '1111') or (user == 'arash' and senha == '0000') or (user == 'vinicius' and senha == '1234')or (user == 'guilherme' and senha == '4321') \
          or (user == 'giovanne' and senha == '007') :
    return render_template('Templatedic.html', nome=user.upper())
  else:
    return render_template('Templatedic.html')

@app.route('/go')
def process():
  return render_template('Templatedic.html', nome="")


'''Aqui comeca  '''

# @app.route('/select_a')
# def a():
#   banco = bd.SQL("root", "SENHA", "test_1")
#   comando = "SELECT DISTINCT modelo, ano, marca FROM automoveis WHERE marca = 'Toyota' ORDER BY ano ASC;"
#   cs = banco.consultar(comando, [])
#   dados = ""
#   for (modelo, ano,marca) in cs:
#       dados += '''
#                   <h3>{}</h3>
#                   <div>
#                       <table>
#                         <tr>
#                           <td style='padding: 30px'>
#                             <p>Modelo : {}</p>
#                             <p>Ano : {} </p>
#                           </td>
#                           <td style='padding: 30px'>
#                              <img src="\static\{}.jpg" width="300px" height="200px">
#                           </td>
#                         </tr>
#                       </table>
#                   </div>
#                '''.format(modelo,modelo ,ano,marca)
#   return render_template('accordion.html', dados = dados)
#
# @app.route('/select_a2')
# def a2():
#   banco = bd.SQL("root", "SENHA", "test_1")
#   comando = """
#   SELECT contato, sigla
# FROM agencia
# WHERE nome LIKE 'A%'
# ORDER BY sigla ASC;
#   """
#   cs = banco.consultar(comando, [])
#   dados = ""
#   for (contato, sigla) in cs:
#       dados += '''
#                   <h3>{}</h3>
#                   <div>
#                       <table>
#                         <tr>
#                           <td style='padding: 30px'>
#                             <p>sigla : {}</p>
#                             <p>contato : {} </p>
#                           </td>
#                         </tr>
#                       </table>
#                   </div>
#                '''.format(contato, sigla,contato)
#   return render_template('accordion.html', dados = dados)
#

app.run(debug=True)