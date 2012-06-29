from pyramid.httpexceptions import HTTPFound

from pyramid.view import (
    view_config,
    view_defaults,
)

from pyramid.security import Authenticated

from ...models import DBSession
from ...models.user import User


@view_defaults(
    route_name='user_delete',
    permission=Authenticated,
)
class UserDeleteView(object):
    def __init__(self, request):
        self.request = request
        self.user = User.by_id(request.matchdict.get('user_id'))

    @view_config(request_method="GET")
    def get(self):
        request = self.request
        if not self.user:
            request.session.flash('Error loading user record!', 'error')
        else:
            DBSession.delete(self.user)
            DBSession.flush()
            request.session.flash('User deleted successfully!')
        return HTTPFound(location=request.route_url('user_list'))
