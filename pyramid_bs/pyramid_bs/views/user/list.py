from pyramid.view import (
    view_config,
    view_defaults,
)

from pyramid.security import Authenticated

from ...models.user import User


@view_defaults(
    route_name='user_list',
    permission=Authenticated,
)
class UserListView(object):
    def __init__(self, request):
        self.request = request

    @view_config(renderer='/user/list.mako', request_method="GET")
    def get(self):
        return {
            'users': User.get_all(),
        }
