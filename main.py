from repl import *


def start():
    """ setting up the repl loop """

    init()

    # setup needed objects:
    scheme_reader = reader.Reader()
    scheme_evaluator = evaluator.Evaluator()
    scheme_printer = printer.Printer()

    while True:

        input_string = raw_input('<scheme>: ')

        # create a stream object from string
        read_stream = string_stream.StringStream(input_string)
        write_stream = string_stream.StringStream()

        # retrieve parsed string as list from reader
        scheme_obj = scheme_reader.read_from_stream(read_stream)

        # hand list over to eval [skipped for now!]
        # evaluated_list = scheme_evaluator.evaluate(parsed_list)

        # print dat shite!
        scheme_printer.print_scheme_object(scheme_obj, write_stream)

        print write_stream.get_stream()


def init():
    """ loading standard library into VM """
    pass


# if called via console:
if __name__ == '__main__':
    start()
