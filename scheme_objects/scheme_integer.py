from scheme_objects.scheme_number import SchemeNumber


class SchemeInteger(SchemeNumber):
    """Scheme Integer Values"""

    def __init__(self, num_value):
        super(SchemeInteger, self).__init__(num_value)

    def is_scheme_integer(self):
        return True
