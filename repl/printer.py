class Printer(object):
    """
        responsible for printing out evaluated expressions and symbols
    """
    def print_scheme(self, result_list):
        output_string = result_list.to_string()
        print output_string
