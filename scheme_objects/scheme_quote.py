from scheme_objects.scheme_object import SchemeObject


class SchemeQuote(SchemeObject):
    """
        Stores a Scheme Quote as a string, which needs to be parsed and
        evaluated upon usage.
    """
    _content = None

    def __init__(self, content=""):
        super(SchemeQuote, self).__init__(num_value)
        self._content = content

    def get_content(self):
        return self._content

    def is_scheme_quote(self):
        return True

