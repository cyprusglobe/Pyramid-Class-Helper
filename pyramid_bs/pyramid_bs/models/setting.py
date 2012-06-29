from sqlalchemy import (
    Column,
    Integer,
    Text
)

from sqlalchemy.types import PickleType

from . import (
    Base,
    DBSession
)


class Setting(Base):
    __tablename__ = 'setting'
    id = Column(Integer, primary_key=True)
    name = Column(Text, unique=True, nullable=False)
    value = Column(PickleType, nullable=False)

    def __init__(self, name, value):
        self.name = unicode(name)
        self.value = value

    def __repr__(self):
        return "<Setting %s>" % (self.name)

    @classmethod
    def by_name(cls, name):
        return DBSession.query(cls).filter(cls.name == unicode(name)).first()

    @classmethod
    def value_by_name(cls, name):
        s = cls.by_name(unicode(name))
        if s:
            return s.value
        return None
