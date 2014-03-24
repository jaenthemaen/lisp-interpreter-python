class SchemeObject(object):
    """ root object for all scheme objects """

    def is_scheme_boolean(self):
        return False

    def is_scheme_true(self):
        return False

    def is_scheme_false(self):
        return False

    def is_scheme_cons(self):
        return False

    def is_scheme_number(self):
        return False

    def is_scheme_float(self):
        return False

    def is_scheme_integer(self):
        return False

    def is_scheme_nil(self):
        return False

    def is_scheme_string(self):
        return False

    def is_scheme_symbol(self):
        return False

    def is_scheme_user_defined_function(self):
        return False

    def is_scheme_void(self):
        return False

    def is_scheme_quote(self):
        return False


class SchemeBoolean(SchemeObject):
    """ The nil object. """

    def __init__(self):
        super(SchemeBoolean, self).__init__()

    @staticmethod
    def is_scheme_boolean(self):
        return True


class SchemeFalse(SchemeBoolean):
    _instance = None

    def __new__(cls, *args):
        if not cls._instance:
            cls._instance = super(SchemeFalse, cls).__new__(cls, *args)
        return cls._instance

    @staticmethod
    def to_string(self):
        return "#f"

    @staticmethod
    def is_scheme_false(self):
        return True


class SchemeTrue(SchemeBoolean):
    _instance = None

    def __new__(cls, *args):
        if not cls._instance:
            cls._instance = super(SchemeTrue, cls).__new__(cls, *args)
        return cls._instance

    @staticmethod
    def to_string(self):
        return "#t"

    @staticmethod
    def is_scheme_true(self):
        return True


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


class SchemeEnvironment(SchemeObject):
    """
        represents environments of the scheme code being executed.
        has a hash table containing all defined vars in this environment
        and a reference to its parent environment, or None, if it is the
        global environment
    """
    __global_env=None
    def __init__ (self, parent_env=None):
        self.map = OrderedDict()
        self.map_index = []
        self.parent_env = parent_env



class SchemeContinuation(SchemeObject):
    """

    """
    def __init__(self, parent, env, func, ast, args, retValIndex):
        self.parent_cont = parent
        self.environment = env
        self.function = func
        self.ast = ast
        self.args = args
        self.retValIndex = retValIndex


class SchemeNumber(SchemeObject):
    """ Base class for integers and floats """

    def __init__(self, num_value):
        super(SchemeObject, self).__init__()
        self.value = num_value

    def to_string(self):
        return str(self.value)

    def is_scheme_number(self):
        return True


class SchemeFloat(SchemeNumber):
    """ Float values. """

    def __init__(self, num_value):
        super(SchemeFloat, self).__init__(num_value)

    def is_scheme_float(self):
        return True


class SchemeInteger(SchemeNumber):
    """Scheme Integer Values"""

    def __init__(self, num_value):
        super(SchemeInteger, self).__init__(num_value)

    def is_scheme_integer(self):
        return True


class SchemeNil(SchemeObject):
    """ The nil object. """
    _instance = None

    def __new__(cls, *args):
        if not cls._instance:
            cls._instance = super(SchemeNil, cls).__new__(cls, *args)
        return cls._instance

    def is_scheme_nil(self):
        return True


class SchemeQuote(SchemeObject):
    """
        Stores a Scheme Quote. Capsulates inner Objects that are already parsed.
    """
    _content = None

    def __init__(self, content):
        super(SchemeQuote, self).__init__()
        self._content = content

    def get_content(self):
        return self._content

    def is_scheme_quote(self):
        return True


class SchemeString(SchemeObject):
    """ String in scheme representation """

    def __init__(self, string_content):
        super(SchemeString, self).__init__()
        self.content = string_content

    def to_string(self):
        return '"' + self.content + '"'

    def is_scheme_string(self):
        return True


class SchemeSymbol(SchemeObject):
    """ all symbols and identifiers """

    def __init__(self, aName):
        super(SchemeSymbol, self).__init__()
        self.name = aName

    def to_string(self):
        return self.name

    def is_scheme_symbol(self):
        return True


class SchemeUserDefinedFunction(SchemeObject):
    """ u def f """

    def __init__(self, name):
        super(SchemeUserDefinedFunction, self).__init__()
        self.name = name

    def to_string(self):
        return self.name

    def is_scheme_user_defined_function(self):
        return True


class SchemeVoid(SchemeObject):
    """docstring for SchemeVoid"""
    _instance = None

    def __new__(cls, *args):
        if not cls._instance:
            cls._instance = super(SchemeVoid, cls).__new__(cls, *args)
        return cls._instance

    def is_scheme_void(self):
        return True