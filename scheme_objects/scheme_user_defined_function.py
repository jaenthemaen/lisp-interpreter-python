from scheme_objects.scheme_object import SchemeObject


class SchemeUserDefinedFunction(SchemeObject):
    """ u def f """

    def __init__(self, name):
        super(SchemeUserDefinedFunction, self).__init__()
        self.name = name

    def to_string(self):
        return self.name

    def is_scheme_user_defined_function(self):
        return True