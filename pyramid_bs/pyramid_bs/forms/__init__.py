from wtforms import Form


class AjaxForm(Form):
    def json_errors(self):
        field_errors = {}
        validated = self.validate()
        for name in self.data:
            field = self.__getattribute__(name)
            if field.errors:
                field_errors[name] = {
                    'error': True,
                    'message': field.errors[0]
                }
        return {
            'fields': field_errors,
            'validated': validated
        }
