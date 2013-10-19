from scheme_objects.scheme_object import SchemeObject


class SchemeNil(SchemeObject):
    """ The nil object. """
    _instance = None

    def __new__(cls, *args):
        if not cls._instance:
            cls._instance = super(SchemeNil, cls).__new__(cls, *args)
        return cls._instance

    def is_scheme_nil(self):
        return True