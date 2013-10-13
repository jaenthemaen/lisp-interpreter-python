class Reader(object):
    """ responsible for reading and parsing incoming code """
    def read(self, stringstream):
        current_char = ""

        while True:
            current_char = stringstream.read_char()
            print current_char
            if current_char == "EOF":
                break

