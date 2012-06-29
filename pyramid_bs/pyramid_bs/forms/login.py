from wtforms import (
    PasswordField,
    TextField,
    validators
)

from ..forms import AjaxForm


class LoginForm(AjaxForm):
    login = TextField('Login', [validators.Length(min=4, max=10)])
    password = PasswordField('Password', [validators.Length(min=6, max=15)])

class EditForm(AjaxForm):
    login = TextField('Login', [validators.Length(min=4, max=10)])
    password = PasswordField('Password', [validators.Length(min=6, max=15)])
    confirm = PasswordField('Confrim', [validators.EqualTo(
        'password', message='Passwords must match')])
    first_name = TextField('First Name', [validators.Length(min=2, max=25)])
    last_name = TextField('Last_name', [validators.Length(min=2, max=25)])
    phone = TextField('Phone', [])
    email = TextField('Email', [validators.email()])
