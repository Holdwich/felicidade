from sqlalchemy import create_engine, text , func
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

    def consultarEstatisticastipo(self):
        result = self.ses.query(self.tipo_ocorrencia.tipo_ocorrencia_nome, func.count(self.ocorrencia.id_ocorrencia).label('total')). \
            join(self.ocorrencia, self.ocorrencia.id_tipo_ocorrencia_fk == self.tipo_ocorrencia.id_tipo_ocorrencia). \
            group_by(self.tipo_ocorrencia.tipo_ocorrencia_nome).all()

        return result
    
    def consultarEstatisticaslugar(self): 
        result = self.ses.query(self.lugar.lugar_nome, func.count(self.ocorrencia.id_ocorrencia).label('total')). \
            join(self.sublugar,self.lugar.id_lugar == self.sublugar.id_lugar_fk). \
            join(self.ocorrencia, self.ocorrencia.id_sub_lugar_fk == self.sublugar.id_sub_lugar). \
            group_by(self.lugar.lugar_nome).all()
        return result

    def consultarEstatisticasdata(self):
        result = self.ses.query(func.MONTH(self.ocorrencia.ocorrencia_data_registro).label('mes'),
                        func.count(self.ocorrencia.id_ocorrencia).label('total')). \
            group_by('mes').order_by('mes').all()
        return result
        
    def consultarOcorrencias(self):
        result = self.ses.query(
            self.setor.setor_nome.label('SETOR'),
            self.tipo_ocorrencia.tipo_ocorrencia_nome.label('TIPO_OCORRENCIA'),
            self.pessoa.pessoa_nome.label('NOME'),
            self.ocorrencia.ocorrencia_descricao.label('DESCRICAO'),
            self.ocorrencia.id_ocorrencia.label('ID_OCORRENCIA'),
            self.ocorrencia.ocorrencia_data.label('DATA_OCORRIDO'),
            self.ocorrencia.ocorrencia_data_registro.label('DATA_REGISTRO'),
            self.ocorrencia.ocorrencia_status.label('OCORRENCIA_STATUS'),
            self.lugar.lugar_nome.label('LOCAL'),
            self.sublugar.sub_lugar_nome.label('SUB_LOCAL')). \
        join(self.tipo_ocorrencia,self.ocorrencia.id_tipo_ocorrencia_fk == self.tipo_ocorrencia.id_tipo_ocorrencia). \
        join(self.setor,self.tipo_ocorrencia.id_setor_fk == self.setor.id_setor). \
        join(self.pessoa,self.ocorrencia.id_pessoa_fk == self.pessoa.pessoa_id_pessoa). \
        join(self.sublugar,self.ocorrencia.id_sub_lugar_fk == self.sublugar.id_sub_lugar). \
        join(self.lugar,self.sublugar.id_lugar_fk == self.lugar.id_lugar).order_by(self.setor.setor_nome).all()

        return result

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

    def get_max_id(self, id_max):
        query = f"SELECT MAX({id_max}) FROM {self.tabelaStr}"

        resultado = self.ses.execute(text(query))

        max_id = resultado.fetchone()[0]

        return max_id if max_id is not None else 0

    def __del__(self):
        self.ses.close()
