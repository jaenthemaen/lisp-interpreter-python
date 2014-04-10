from collections import OrderedDict


class SchemeObject(object):
    """ root object for all scheme objects """
    def is_scheme_object(self):
        return True

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

    def is_scheme_builtin(self):
        return False

    def is_scheme_lambda(self):
        return False

    def is_scheme_syntax(self):
        return False


class SchemeBoolean(SchemeObject):
    """ The nil object. """

    def __init__(self):
        super(SchemeBoolean, self).__init__()

    @staticmethod
    def is_scheme_boolean(self):
        return True


class SchemeFalse(SchemeBoolean):
    """ Singleton. """
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
    """ Singleton. """
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

    def __init__(self, car=None, cdr=None):
        super(SchemeCons, self).__init__()
        if car is None:
            car = SchemeNil()
        if cdr is None:
            cdr = SchemeNil()
        self.car = car
        self.cdr = cdr

    def to_string(self):
        return '(' + self.car.to_string() + ' ' + self.cdr.to_string() + ')'

    def is_scheme_cons(self):
        return True

    def list_length(self):
        length = 0
        current_cons = self
        while current_cons.is_scheme_cons():
            length += 1
            current_cons = current_cons.cdr
        return length

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


class SchemeEnvironment(SchemeObject):
    """
        represents environments of the scheme code being executed.
        has a hash table containing all defined vars in this environment
        and a reference to its parent environment, or None, if it is the
        global environment
    """
    def __init__ (self, parent_env=None):
        self.map = dict()
        self.parent_env = parent_env

    def add_binding(self, symbol, scheme_object):
        if symbol is not None and symbol != "" and scheme_object.is_scheme_object():
            if not symbol in self.map:
                self.map[symbol] = scheme_object
            else:
                return BindingAlreadyExistingException("Symbol already bound, no binding possible.", symbol)
        else:
            raise Exception("Either not a valid symbol or no scheme object given.")

    def get_binding(self, symbol):
        if symbol is not None and symbol != "":
            if self.map[symbol] is not None:
                return self.map[symbol]
            elif self.parent_env is None:
                return NoBindingForSymbolException("Symbol unbound, nothing to return.", symbol)
            else:
                return self.parent_env.get_binding(symbol)
        else:
            return Exception("No symbol given.")

    def set_binding(self, symbol, scheme_object):
        if symbol is not None and symbol != "" and type(scheme_object) == SchemeObject:
            if self.map[symbol] is None:
                NoBindingForSymbolException("Trying to set unbound symbol.", symbol)
            else:
                self.map[symbol] = scheme_object
        else:
            raise Exception("Either not a valid symbol or no scheme object given.")


class SchemeContinuation(SchemeObject):
    """
        Whenever a function gets called or something else is evaluated,
        a continuation is stored with the informations on where to proceed etc.
    """
    def __init__(self, parent_cont, env, func, ast, args, ret_val, args_count=0):
        self.parent_cont = parent_cont
        #TODO use handed env or create new one with handed as parent?
        # lambda und begin -> eigenes env
        self.env = env
        # python func
        self.function = func
        # scheme ast
        self.ast = ast
        # unevaled args as python list
        self.args = args
        # evaled args count
        self.evaled_args_count = args_count
        # known in function. not here
        # self.args_evaluated = False
        # ret_val is filled by called function if needed!
        # index im arguments array der uebergeordneten continuation
        # dort return wert hinschreiben
        self.ret_val = ret_val


class SchemeBuiltin(SchemeObject):
    """  """
    def __init__(self, func, args_count):
        self.args_count = args_count
        self.func = func

    def is_scheme_builtin(self):
        return True


# TODO check SchemeLambda
class SchemeLambda(SchemeObject):
    """ """
    # TODO does env need to be linked here?
    def __init__(self, args, body, env):
        self.args = args
        self.body = body
        self.env = env

    def is_scheme_lambda(self):
        return True


# TODO check SchemeSyntax
class SchemeSyntax(SchemeObject):
    """ """
    # TODO does env need to be linked here?
    def __init__(self, args, body, env):
        self.args = args
        self.body = body
        self.env = env

    def is_scheme_syntax(self):
        return True


# Exceptions Used in this module:
#
class BindingAlreadyExistingException(Exception):
    """
        The given symbol already had a binding.
    """
    def __init__(self, message, symbol):
        super(BindingAlreadyExistingException, self).__init__(message)
        self.content = symbol


class NoBindingForSymbolException(Exception):
    """
        The requested symbol had no binding.
    """
    def __init__(self, message, symbol):
        super(NoBindingForSymbolException, self).__init__(message)
        self.content = symbol