from pyramid.events import NewRequest

from pyramid.events import subscriber
from pyramid.httpexceptions import HTTPForbidden
from pyramid.security import authenticated_userid


def _csrf_token(request):
    return request.session.get_csrf_token()


def _flash_messages(request):
    msgs = []
    if request.session.peek_flash():
        for msg in request.session.pop_flash():
            msgs.append(msg)
    return msgs


def _error_messages(request):
    msgs = []
    if request.session.peek_flash('error'):
        for msg in request.session.pop_flash('error'):
            msgs.append(msg)
    return msgs


@subscriber(NewRequest)
def csrf_validation(event):
    request = event.request

    # add flash_messages to the request object
    request.set_property(_csrf_token, 'csrf_token', reify=True)

    # add error_messages to the request object
    request.set_property(_error_messages, 'error_messages', reify=True)

    # add flash_messages to the request object
    request.set_property(_flash_messages, 'flash_messages', reify=True)

    request.set_property(authenticated_userid, 'userid', reify=True)

    if request.method == "POST":
        # keep the debugtoolbar from failing because of missing _csrf tokens
        if request.path_info_peek().startswith('_debug_toolbar'):
            return
        token = request.POST.get("_csrf")
        if token is None or token != request.session.get_csrf_token():
            raise HTTPForbidden('CSRF token is missing or invalid')
