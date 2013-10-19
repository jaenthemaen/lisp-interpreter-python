from scheme_objects.scheme_object import SchemeObject

class SchemeCons(SchemeObject):
    """ SchemeCons : Basic Tuple Data Structure """

    def __init__(self, aCar, aCdr):
        super(SchemeCons, self).__init__()
        self.car = aCar
        self.cdr = aCdr

    def to_string(self):
        return '(' + self.car.to_string() + ' ' + self.cdr.to_string() + ')'

    def is_scheme_cons(self):
        return True

