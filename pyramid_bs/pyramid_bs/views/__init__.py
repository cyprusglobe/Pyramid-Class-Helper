from pyramid.httpexceptions import HTTPForbidden
from pyramid.httpexceptions import HTTPFound
from pyramid.security import authenticated_userid


def forbidden(request):
    # do not allow a user to login if they are already logged in
    if authenticated_userid(request):
        return HTTPForbidden()

    location = request.route_url('index', _query=(('next', request.path),))
    return HTTPFound(location=location)
