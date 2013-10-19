from scheme_objects.scheme_object import SchemeObject


class SchemeNumber(SchemeObject):
    """ Base class for integers and floats """

    def __init__(self, num_value):
        super(SchemeObject, self).__init__()
        self.value = num_value

    def to_string(self):
        return str(self.value)

    def is_scheme_number(self):
        return True
