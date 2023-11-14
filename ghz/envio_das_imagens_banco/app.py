from flask import Flask, request, render_template, jsonify
import os
from imagens_connection import insert_image

app = Flask(__name__)

UPLOAD_FOLDER = 'ocorrencias'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'webp'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/', methods=['GET', 'POST'])
def upload_file():

    if request.method == 'POST':
        if 'imagem' not in request.files:
            return jsonify({'message': 'sem arquivo'}), 400

        imagem = request.files['imagem']

        if imagem.filename == '':
            return jsonify({'message': 'sem arquivo'}), 400

        if imagem and allowed_file(imagem.filename):
            novo_nome = f'ocorrencia_1.' + imagem.filename.rsplit('.', 1)[1].lower()
            imagem.save(os.path.join(app.config['UPLOAD_FOLDER'], novo_nome))
            insert_image(os.getcwd() + rf'\ocorrencias\{novo_nome}', novo_nome)
            os.remove(os.getcwd() + rf'\ocorrencias\{novo_nome}')
            return jsonify({'message': 'imagem enviada', 'novo_nome': novo_nome}), 200
        else:
            return jsonify({'message': 'use somente PNG, JPG ou WEBP'}), 400



    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
