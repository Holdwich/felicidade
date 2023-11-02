from sqlalchemy import create_engine
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import sessionmaker


class DAO:
    def __init__(self, tab):
        # Ligação com o esquema de banco de dados
        engine = create_engine(
            "mysql+mysqlconnector://root:uniceub@localhost/felicidade?charset=utf8mb4"
        )

        # Mapeamento Objeto Relacional com o SQLAlchemy
        db = automap_base()
        db.prepare(autoload_with=engine)
        self.lugar = db.classes.lugar
        self.midia = db.classes.midia
        self.ocorrencia = db.classes.ocorrencia
        self.pessoa = db.classes.pessoa
        self.setor = db.classes.setor
        self.sublugar = db.classes.sublugar
        self.tipo_ocorrencia = db.classes.tipo_ocorrencia

        self.tabela = eval("db.classes." + tab)
        self.tabelaStr = tab

        self.id = "id_" + tab

        # Trabalho com sessões da base Objeto-Relacional
        session_factory = sessionmaker(bind=engine)
        self.ses = session_factory()
        # -------------------------------------------------------------------------------------------------

    def checkLogin(self, email, senha):
        query = (
            "SELECT COUNT(*) FROM pessoa WHERE email = "
            + email
            + " AND senha = SHA1("
            + senha
            + ")"
        )

        resultado = self.ses.execute(query)

        count = resultado.scalar()

        return count

    def selectCount(self, campo, valor):
        query = (
            "SELECT COUNT(*) FROM " + self.tabelaStr + " WHERE " + campo + " = " + valor
        )

        resultado = self.ses.execute(query)

        count = resultado.scalar()

        return count

    def selectFromWhere(self, campoReferencia, valor, campoBuscado="*"):
        if campoBuscado == "*":
            stmt = select([self.tabela]).where(self.tabela.c[campoReferencia] == valor)

        else:
            stmt = select([self.tabela.c[campoBuscado]]).where(
                self.tabela.c[campoReferencia] == valor
            )

        resultado = self.ses.execute(stmt)

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