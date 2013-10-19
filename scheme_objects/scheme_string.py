from scheme_objects.scheme_object import SchemeObject

class SchemeString(SchemeObject):
    """ String in scheme representation """

    def __init__(self, string_content):
        super(SchemeString, self).__init__()
        self.content = string_content

    def to_string(self):
        return '"' + self.content + '"'

    def is_scheme_string(self):
        return True
