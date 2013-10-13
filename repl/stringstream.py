class Stringstream(object):

    def __init__(self, stringinput = ""):
        self.stream = stringinput.strip()

    def read_char(self):
        if len(self.stream) > 0:
            first_char = self.stream[0]
            self.stream = self.stream[1:]
            return first_char
        else:
            return "EOF"

    def peek_char(self):
        if len(self.stream) > 0:
            return self.stream[0]
        else:
            return "EOF"

    def set_stream(self, stringinput):
        self.stream = stringinput

