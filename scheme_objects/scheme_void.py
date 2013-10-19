from scheme_objects.scheme_object import SchemeObject


class SchemeVoid(SchemeObject):
    """docstring for SchemeVoid"""
    _instance = None

    def __new__(cls, *args):
        if not cls._instance:
            cls._instance = super(SchemeVoid, cls).__new__(cls, *args)
        return cls._instance

    def is_scheme_void(self):
        return True

