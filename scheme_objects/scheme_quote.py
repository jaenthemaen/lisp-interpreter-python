from scheme_objects.scheme_object import SchemeObject


class SchemeQuote(SchemeObject):
    """
        Stores a Scheme Quote. Capsulates inner Objects that are already parsed.
    """
    _content = None

    def __init__(self, content):
        super(SchemeQuote, self).__init__()
        self._content = content

    def get_content(self):
        return self._content

    def is_scheme_quote(self):
        return True

