from scheme_objects import SchemeObject
from utilities import StringStream


def print_scheme_object(scheme_obj, stream):
    # assert isinstance(scheme_obj, SchemeObject)
    assert isinstance(stream, StringStream)

    if scheme_obj.is_scheme_cons():
        return print_scheme_list(scheme_obj, stream)

    if scheme_obj.is_scheme_float():
        return print_scheme_float(scheme_obj, stream)

    if scheme_obj.is_scheme_integer():
        return print_scheme_integer(scheme_obj, stream)

    if scheme_obj.is_scheme_string():
        return print_scheme_string(scheme_obj, stream)

    if scheme_obj.is_scheme_symbol():
        stream.write_chars(scheme_obj.name)
        return

    if scheme_obj.is_scheme_false():
        stream.write_chars('#f')
        return

    if scheme_obj.is_scheme_true():
        stream.write_chars('#t')
        return

    if scheme_obj.is_scheme_quote():
        stream.write_chars("'")
        return print_scheme_object(scheme_obj.get_content(), stream)

    if scheme_obj.is_scheme_void():
        return

    if scheme_obj.is_scheme_nil():
        stream.write_chars('()')

    if scheme_obj.is_scheme_user_defined_function():
        raise Exception("user def funcs not implemented yet!")

    # if no object type could be detected:
    raise Exception("Printer encountered unknown input string!" + str(scheme_obj))


def print_scheme_list(scheme_obj, stream):
    stream.write_chars('(')
    print_scheme_rest_list(scheme_obj, stream)


def print_scheme_rest_list(scheme_obj, stream):
    print_scheme_object(scheme_obj.car, stream)
    if scheme_obj.cdr.is_scheme_nil():
        stream.write_chars(')')
    elif scheme_obj.cdr.is_scheme_cons():
        stream.write_chars(' ')
        print_scheme_rest_list(scheme_obj.cdr, stream)
    # malformed cons!
    else:
        stream.write_chars(' . ')
        print_scheme_object(scheme_obj.cdr, stream)
        stream.write_chars(')')

def print_scheme_float(scheme_obj, stream):
    stream.write_chars(str(scheme_obj.value))


def print_scheme_integer(scheme_obj, stream):
    stream.write_chars(str(scheme_obj.value))


def print_scheme_string(scheme_obj, stream):
    stream.write_chars('"' + scheme_obj.content + '"')






