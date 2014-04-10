import evaluator, reader, printer, utilities

def start():
    """ setting up the repl loop """
    # load std lib
    init()

    while True:

        input_string = raw_input('<scheme>: ')

        # create a stream object from string
        read_stream = utilities.StringStream(input_string)
        write_stream = utilities.StringStream()

        # retrieve parsed string as list from reader
        parsed_scheme = reader.read_from_stream(read_stream)

        # hand list over to eval
        evaluator.evaluate(parsed_scheme, write_stream)

        print write_stream.get_stream()



def init():
    """ loading standard library into VM """
    pass


# if called via console:
if __name__ == '__main__':
    start()
