from scheme_objects.scheme_object import SchemeObject


class SchemeSymbol(SchemeObject):
    """ all symbols and identifiers """

    def __init__(self, aName):
        super(SchemeSymbol, self).__init__()
        self.name = aName

    def to_string(self):
        return self.name

    def is_scheme_symbol(self):
        return True