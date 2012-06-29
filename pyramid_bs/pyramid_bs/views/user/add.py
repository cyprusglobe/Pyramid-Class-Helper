import functools
import transaction

from pyramid.httpexceptions import HTTPFound

from pyramid.view import (
    view_config,
    view_defaults,
)

from pyramid.security import Authenticated

from sqlalchemy.exc import IntegrityError

from ...forms.login import EditForm
from ...models import DBSession
from ...models.user import User
from ...utils import memoized


@view_defaults(
    route_name='user_add',
    permission=Authenticated,
)
class UserAddView(object):
    def __init__(self, request):
        self.request = request
        self.form = functools.partial(self._form)

    @memoized
    def _form(self):
        request = self.request
        formdata = request.GET if request.is_xhr else request.POST
        return EditForm(formdata)

    @view_config(renderer='json', request_method="GET", xhr=True)
    def xhr(self):
        form = self.form()
        return form.json_errors()

    @view_config(renderer='/user/form.mako', request_method="GET")
    def get(self):
        return {
            'form': self.form(),
        }

    @view_config(renderer='/user/form.mako', request_method="POST")
    def post(self):
        form = self.form()
        request = self.request
        savepoint = transaction.savepoint()
        try:
            if form.validate():
                user = User()
                form.populate_obj(user)
                DBSession.add(user)
                DBSession.flush()
                request.session.flash('Added successfuly!')
                return HTTPFound(location=request.route_url('user_list'))

        except IntegrityError:
            request.session.flash('Sorry that login exists!')
            savepoint.rollback()

        except:
            request.session.flash('Error!')
            savepoint.rollback()

        return self.get()
