from sqlalchemy import create_engine, text
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import sessionmaker


class DAO:
    def __init__(self, tab):
        # Ligação com o esquema de banco de dados
        engine = create_engine(
            "mysql+mysqlconnector://root:Gatitcha1@localhost/felicidade?charset=utf8mb4"
        )

        # Mapeamento Objeto Relacional com o SQLAlchemy
        db = automap_base()
        db.prepare(autoload_with=engine)
        self.lugar = db.classes.tb_lugar
        self.midia = db.classes.tb_midia
        self.ocorrencia = db.classes.tb_ocorrencia
        self.pessoa = db.classes.tb_pessoa
        self.setor = db.classes.tb_setor
        self.sublugar = db.classes.tb_sub_lugar
        self.tipo_ocorrencia = db.classes.tb_tipo_ocorrencia

        self.tabela = eval("db.classes.tb_" + str(tab))
        self.tabelaStr = "tb_" + tab

        self.id = "id_" + tab

        # Trabalho com sessões da base Objeto-Relacional
        session_factory = sessionmaker(bind=engine)
        self.ses = session_factory()
        # -------------------------------------------------------------------------------------------------

    def checkLogin(self, email, senha):
        query = (
            "SELECT COUNT(*) FROM tb_pessoa WHERE pessoa_email = '"
            + email
            + "' AND pessoa_senha = '"
            + senha
            + "'"
        )

        resultado = self.ses.execute(text(query))

        count = resultado.scalar()

        return count

    def selectCount(self, campo, valor):
        query = (
            "SELECT COUNT(*) FROM "
            + self.tabelaStr
            + " WHERE "
            + campo
            + " = '"
            + valor
            + "'"
        )

        resultado = self.ses.execute(text(query))

        count = resultado.scalar()

        return count

    def selectFromWhere(self, campoReferencia, valor, campoBuscado="*"):
        query = (f"SELECT {campoBuscado} FROM {self.tabelaStr} WHERE {campoReferencia} = '{valor}'")

        resultado = self.ses.execute(text(query))

        linhas = resultado.fetchall()

        return linhas

    def create(self, obj):
        self.ses.add(obj)
        self.ses.commit()
    def readAll(self):
        lista = self.ses.query(self.tabela).all()
        return lista

    def readById(self, id):
        exp = "self.tabela." + self.id + "==" + id
        obj = self.ses.query(self.tabela).filter(eval(exp)).first()
        return obj

    def readBy(self, campo, oper, valor):
        if oper == "==":
            exp = "self.tabela." + campo + "==" + valor
        elif oper == "ilike":
            exp = "self.tabela." + campo + ".ilike('%' " + valor + " '%')"
        else:
            exp = "self.tabela." + campo + oper + valor

        lista = self.ses.query(self.tabela).filter(eval(exp)).all()
        return lista

    def update(self):
        self.ses.commit()

    def delete(self, obj):
        self.ses.delete(obj)
        self.ses.commit()

    def getSes(self):
        return self.ses

    def __del__(self):
        self.ses.close()
