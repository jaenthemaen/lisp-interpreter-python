class Reader(object):
    """ responsible for reading and parsing incoming code """

    def readFromStream(self, stream):
        peek_char = ""

        stream.skip_spaces()

        peek_char = stream.peek_char()

        if peek_char.isdigit():
            return self.readNumberFromStream(stream)

        if peek_char == '"':
            return self.readStringFromStream(stream)

        if peek_char == "(":
            return self.readListFromStream(stream)

        return self.readSymbolFromStream(stream)

    def readNumberFromStream(self, stream):
        pass

    def readListFromStream(self, stream):
        pass

    def readSymbolFromStream(self, stream):
        pass
