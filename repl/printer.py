from scheme_objects.scheme_object import SchemeObject
from repl.string_stream import StringStream


class Printer(object):
    """
        responsible for printing out evaluated expressions and symbols
    """

    def print_scheme_object(self, scheme_obj, stream):
        assert isinstance(scheme_obj, SchemeObject)
        assert isinstance(stream, StringStream)

        if scheme_obj.is_scheme_cons():
            return self.print_scheme_list(scheme_obj, stream)

        if scheme_obj.is_scheme_float():
            return self.print_scheme_float(scheme_obj, stream)

        if scheme_obj.is_scheme_integer():
            return self.print_scheme_integer(scheme_obj, stream)

        if scheme_obj.is_scheme_string():
            return self.print_scheme_string(scheme_obj, stream)

        if scheme_obj.is_scheme_symbol():
            stream.write_chars(scheme_obj.name)
            return

        if scheme_obj.is_scheme_false():
            stream.write_chars('false')
            return

        if scheme_obj.is_scheme_true():
            stream.write_chars('true')
            return

        if scheme_obj.is_scheme_void():
            return

        if scheme_obj.is_scheme_nil():
            stream.write_chars('()')

        if scheme_obj.is_scheme_user_defined_function():
            raise Exception("user def funcs not implemented yet!")

        # if no object type could be detected:
        raise Exception("UNKNOWN TYPE GIVEN TO READER!" + str(scheme_obj))

    def print_scheme_list(self, scheme_obj, stream):
        stream.write_chars('(')
        self.print_scheme_rest_list(scheme_obj, stream)

    def print_scheme_rest_list(self, scheme_obj, stream):
        self.print_scheme_object(scheme_obj.car, stream)
        if scheme_obj.cdr.is_scheme_nil():
            stream.write_chars(')')
        else:
            stream.write_chars(' ')
            self.print_scheme_rest_list(scheme_obj.cdr, stream)


    def print_scheme_float(self, scheme_obj, stream):
        stream.write_chars(str(scheme_obj.value))

    def print_scheme_integer(self, scheme_obj, stream):
        stream.write_chars(str(scheme_obj.value))

    def print_scheme_string(self, scheme_obj, stream):
        stream.write_chars('"' + scheme_obj.content + '"')






