class SchemeObject(object):
    """ root object for all scheme objects """



    def is_scheme_boolean(self):
        return False

    def is_scheme_true(self):
        return False

    def is_scheme_false(self):
        return False

    def is_scheme_cons(self):
        return False

    def is_scheme_number(self):
        return False

    def is_scheme_float(self):
        return False

    def is_scheme_integer(self):
        return False

    def is_scheme_nil(self):
        return False

    def is_scheme_string(self):
        return False

    def is_scheme_symbol(self):
        return False

    def is_scheme_user_defined_function(self):
        return False

    def is_scheme_void(self):
        return False

    def is_scheme_quote(self):
        return False