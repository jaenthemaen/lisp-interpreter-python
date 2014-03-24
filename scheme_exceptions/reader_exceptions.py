__author__ = 'jan'


class StringUnfinishedException(Exception):
    """
        The string that was parsed missed a closing quote.
        Accepts the current input stream state to be passed to it.
    """
    def __init__(self, message, content=""):
        super(StringUnfinishedException, self).__init__(message)
        self.content = content


class MalformedListException(Exception):
    """
        The list that was parsed had uneven brackets, e.g. missed a closing one.
        Accepts the current input stream state to be passed to it.
    """
    def __init__(self, message, content=""):
        super(MalformedListException, self).__init__(message)
        self.content = content
