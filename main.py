from repl import *


def start():
    """ setting up the repl loop """

    init()

    # setup needed objects:
    scheme_reader = reader.Reader()
    scheme_evaluator = evaluator.Evaluator()
    scheme_printer = printer.Printer()

    while True:

        input_string = raw_input('code some scheme here: ')

        # create a stream object from string
        current_stream = stringstream.Stringstream(input_string)

        # retrieve parsed string as list from reader
        parsed_list = scheme_reader.read_from_stream(current_stream)

        # hand list over to eval
        evaluated_list = scheme_evaluator.evaluate(parsed_list)

        # print dat shite!
        scheme_printer.print_scheme(evaluated_list)


def init():
    """ loading standard library into VM """
    pass


# if called via console:
if __name__ == '__main__':
    start()
