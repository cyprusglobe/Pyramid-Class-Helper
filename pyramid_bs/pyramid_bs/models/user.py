import cryptacular.bcrypt
import transaction
from datetime import datetime

from sqlalchemy import (
    Column,
    Integer,
    Unicode,
)

from sqlalchemy.orm import synonym

from . import (
    Base,
    DBSession
)

crypt = cryptacular.bcrypt.BCRYPTPasswordManager()


class User(Base):
    """
    User model.
    """
    __tablename__ = 'user'
    #__table_args__ = {'mysql_engine': 'InnoDB', 'mysql_charset': 'utf8'}
    id = Column(Integer, primary_key=True)
    login = Column(Unicode(100), unique=True)
    first_name = Column(Unicode(100))
    last_name = Column(Unicode(100))
    phone = Column(Unicode(100))
    email = Column(Unicode(100))

    _password = Column('password', Unicode(100))

    def _get_password(self):
        return self._password

    def _set_password(self, password):
        self._password = self._hash_password(password)

    password = property(_get_password, _set_password)
    password = synonym('_password', descriptor=password)

    def __repr__(self):
        return "<User %s>" % (self.login)

    def _hash_password(self, password):
        return unicode(crypt.encode(password))

    @classmethod
    def by_id(cls, id):
        return DBSession.query(cls).filter(cls.id == id).first()

    @classmethod
    def by_login(cls, login):
        return DBSession.query(cls).filter(cls.login == login).first()

    def change_password(self, password):
        savepoint = transaction.savepoint()
        try:
            dbsession = DBSession()
            self.password = password
            self.timestamp = datetime.now()
            dbsession.flush()

        except Exception:
            savepoint.rollback()
            raise

    @classmethod
    def get_all(cls, query_only=False):
        if query_only:
            return DBSession.query(cls).order_by(cls.login)
        return DBSession.query(cls).order_by(cls.login).all()

    @classmethod
    def check_password(cls, login, password):
        user = cls.by_login(login)
        if not user:
            return False
        return crypt.check(user.password, password)
