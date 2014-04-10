class NotANumberException(Exception):
    """
        NaN handed to arithmetic operation.
    """
    def __init__(self, message="NaN", content=""):
        super(NotANumberException, self).__init__(message)
        self.content = content
