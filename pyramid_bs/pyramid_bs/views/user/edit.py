import functools

from pyramid.httpexceptions import HTTPFound

from pyramid.view import (
    view_config,
    view_defaults,
)

from pyramid.security import Authenticated

from ...forms.login import EditForm
from ...models import DBSession
from ...models.user import User
from ...utils import memoized


@view_defaults(
    route_name='user_edit',
    permission=Authenticated,
)
class UserEditView(object):
    def __init__(self, request):
        self.request = request
        self.user = User.by_id(request.matchdict.get('user_id'))
        self.form = functools.partial(self._form)

    @memoized
    def _form(self):
        request = self.request
        formdata = request.GET if request.is_xhr else request.POST
        return EditForm(formdata, obj=self.user)

    @view_config(renderer='json', request_method="GET", xhr=True)
    def xhr(self):
        form = self.form()
        return form.json_errors()

    @view_config(renderer='/user/form.mako', request_method="GET")
    def get(self):
        request = self.request
        if not self.user:
            request.session.flash('Error loading user record!', 'error')
            return HTTPFound(location=request.route_url('user_list'))
        return {
            'form': self.form(),
            'user': self.user,
        }

    @view_config(renderer='/user/form.mako', request_method="POST")
    def post(self):
        form = self.form()
        request = self.request
        if form.validate():
            if self.user:
                form.populate_obj(self.user)
                DBSession.flush()
                request.session.flash('Updated successfuly!')
            else:
                request.session.flash('Error!', 'error')
            return HTTPFound(location=request.route_url('user_list'))
        return self.get()
