from scheme_objects.scheme_object import SchemeObject


class SchemeBoolean(SchemeObject):
    """ The nil object. """

    def __init__(self):
        super(SchemeBoolean, self).__init__()

    def is_scheme_boolean(self):
        return True


class SchemeFalse(SchemeBoolean):
    _instance = None

    def __new__(cls, *args):
        if not cls._instance:
            cls._instance = super(SchemeFalse, cls).__new__(cls, *args)
        return cls._instance

    def to_string(self):
        return "#f"

    def is_scheme_false(self):
        return True


class SchemeTrue(SchemeBoolean):
    _instance = None

    def __new__(cls, *args):
        if not cls._instance:
            cls._instance = super(SchemeTrue, cls).__new__(cls, *args)
        return cls._instance

    def to_string(self):
        return "#t"

    def is_scheme_true(self):
        return True



