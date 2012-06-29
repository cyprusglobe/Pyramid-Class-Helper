import os
import sys
import transaction

from datetime import datetime, timedelta

from sqlalchemy import engine_from_config

from pyramid.paster import (
    get_appsettings,
    setup_logging,
)

from ..models import (
    DBSession,
    Base,
)

from ..models.user import User


def usage(argv):
    cmd = os.path.basename(argv[0])
    print('usage: %s <config_uri>\n'
          '(example: "%s development.ini")' % (cmd, cmd))
    sys.exit(1)


def main(argv=sys.argv):
    if len(argv) != 2:
        usage(argv)
    config_uri = argv[1]
    setup_logging(config_uri)
    settings = get_appsettings(config_uri)
    engine = engine_from_config(settings, 'sqlalchemy.')
    DBSession.configure(bind=engine)
    Base.metadata.create_all(engine)
    with transaction.manager:
        user = User()
        user.login = u'sheldon'
        user.password = u'test123'
        user.first_name = u'Sheldon'
        user.last_name = u'Jones'
        user.phone = u'505-263-5626'
        user.email = u'sheldon@lobo.net'
        DBSession.add(user)
