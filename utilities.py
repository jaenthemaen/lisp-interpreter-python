class StringStream(object):

    def __init__(self, string_input=""):
        self.stream = string_input

    def skip_spaces(self):
        self.stream = self.stream.lstrip()

    def read_char(self):
        if len(self.stream) > 0:
            first_char = self.stream[0]
            self.stream = self.stream[1:]
            return first_char
        else:
            return None

    def peek_char(self):
        if len(self.stream) > 0:
            return self.stream[0]
        else:
            return None

    def set_stream(self, string_input):
        self.stream = string_input

    def get_stream(self):
        return self.stream

    def write_chars(self, string_input):
        self.stream += string_input