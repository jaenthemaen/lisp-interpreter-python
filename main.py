from repl import *

def start():
    """ setting up the repl loop """

    init()

    # setup needed objects:
    my_reader = reader.Reader()

    while True:
        line = raw_input('Prompt ("stop" to quit): ')
        if line == 'stop':
            break
        current_stream = stringstream.Stringstream(line)
        my_reader.read(current_stream)

def init():
    """ loading standard library into VM """
    pass

if __name__ == '__main__':
    start()
