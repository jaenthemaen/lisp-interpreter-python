from scheme_objects.scheme_integer import SchemeInteger
from scheme_objects.scheme_float import SchemeFloat
from scheme_objects.scheme_nil import SchemeNil
from scheme_objects.scheme_cons import SchemeCons
from scheme_objects.scheme_symbol import SchemeSymbol
from scheme_objects.scheme_string import SchemeString


class StringUnfinishedException(Exception):
    def __init__(self, message, content):
        super(StringUnfinishedException, self).__init__(message)
        self.content = content


class Reader(object):
    """ responsible for reading and parsing incoming code """

    def read_from_stream(self, stream):

        stream.skip_spaces()
        pch = stream.peek_char()

        if pch.isdigit():
            return self.read_number_from_stream(stream)

        if pch == '"':
            stream.read_char()
            return self.read_string_from_stream(stream)

        if pch == "(":
            stream.read_char()
            return self.read_list_from_stream(stream)

        return self.read_symbol_from_stream(stream)

    def read_number_from_stream(self, stream):
        value = ""
        is_float = False

        while stream.peek_char() is not None and stream.peek_char().isdigit():
            value += stream.read_char()

        # next char a '.' or 'f'? FLOAT!
        if stream.peek_char() == '.':
            is_float = True
            value += stream.read_char()

            while stream.peek_char() is not None and stream.peek_char().isdigit():
                value += stream.read_char()

        if is_float:
            return SchemeFloat(float(value))
        else:
            return SchemeInteger(int(value))

    def read_list_from_stream(self, stream):
        element = None
        rest_list = None

        stream.skip_spaces()
        if stream.peek_char() == ')':
            stream.read_char()
            return SchemeNil()

        element = self.read_from_stream(stream)
        rest_list = self.read_list_from_stream(stream)

        return SchemeCons(element, rest_list)

    def read_symbol_from_stream(self, stream):

        symbol_name = ""
        pch = stream.peek_char()

        while pch != None and pch != '(' and pch != ')' and pch.isspace() == False:
            symbol_name += pch
            stream.read_char()
            pch = stream.peek_char()

        return SchemeSymbol(symbol_name)

    def read_string_from_stream(self, stream):

        string_content = ""
        escCh = None
        ch = stream.peek_char()

        while ch != None and ch != '"':
            if ch == '\\':
                stream.read_char()
                escCh = stream.peek_char()

                if escCh == 'n':
                    string_content += '\n'
                else:
                    string_content += escCh
            else:
                string_content += ch
            stream.read_char()
            ch = stream.peek_char()

        if ch == None:
            raise StringUnfinishedException("String didn't end properly with quotes.", string_content)
        elif ch == '"':
            return SchemeString(string_content)
