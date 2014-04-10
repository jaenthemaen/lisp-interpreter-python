from scheme_objects import *
from scheme_exceptions.builtins_exceptions import *

def register_builtins(env):
    env.add_binding('+', SchemeBuiltin(builtin_add, 0))
    env.add_binding('*', SchemeBuiltin(builtin_multiply, 0))

def builtin_add(args):
    val = 0
    is_float = False
    for arg in args:
        # check if class is allowed:
        if not arg.is_scheme_float() and not arg.is_scheme_integer():
            raise NotANumberException("Addition only with numbers allowed.", content=arg)
        if arg.is_scheme_float():
            is_float = True
        val += arg.value
    if is_float:
        return SchemeFloat(val)
    else:
        return SchemeInteger(val)

def builtin_multiply(args):
    val = 1
    is_float = False
    for arg in args:
        # check if class is allowed:
        if not arg.is_scheme_float() and not arg.is_scheme_integer():
            raise NotANumberException("Multiplication only with numbers allowed.", content=arg)
        if arg.is_scheme_float():
            is_float = True
        val *= arg.value
    if is_float:
        return SchemeFloat(val)
    else:
        return SchemeInteger(val)