from scheme_objects.scheme_integer import SchemeInteger


class Reader(object):
    """ responsible for reading and parsing incoming code """

    def read_from_stream(self, stream):
        peek_char = ""

        stream.skip_spaces()

        peek_char = stream.peek_char()

        if peek_char.isdigit():
            return self.read_number_from_stream(stream)

        if peek_char == '"':
            return self.read_string_from_stream(stream)

        if peek_char == "(":
            return self.read_list_from_stream(stream)

        return self.read_symbol_from_stream(stream)

    def read_number_from_stream(self, stream):
        value = 0

        while stream.peek_char() is not None and stream.peek_char().isdigit():
            value = value * 10 + int(stream.read_char())

        return SchemeInteger(value)

    def read_list_from_stream(self, stream):
        pass

    def read_symbol_from_stream(self, stream):
        pass

    def read_string_from_stream(self, stream):
        pass
