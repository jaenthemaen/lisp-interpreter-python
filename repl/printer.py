class Printer(object):
    """
        responsible for printing out evaluated expressions and symbols
    """
    def print_scheme(self, result_list):
        output_string = ""
        for obj in result_list:
			output_string += obj.to_string()
