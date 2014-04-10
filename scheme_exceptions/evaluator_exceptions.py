class ArgumentsCountNotMatchingException(Exception):
    """
        Too many or too few arguments passed to function!.
    """
    def __init__(self, message="Too many or too few arguments passed to function"):
        super(ArgumentsCountNotMatchingException, self).__init__(message)