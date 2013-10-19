from scheme_objects.scheme_number import SchemeNumber

class SchemeFloat(SchemeNumber):
    """ Float values. """

    def __init__(self, num_value):
        super(SchemeFloat, self).__init__(num_value)

    def is_scheme_float(self):
        return True