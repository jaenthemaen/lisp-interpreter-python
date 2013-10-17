import unittest
from repl import *


class TestReaderFunctions(unittest.TestCase):

    def setUp(self):
        self.stream = stringstream.Stringstream()
        self.reader = reader.Reader()
        self.printer = printer.Printer()
        self.obj = None
        self.output_stream = ""

    def test_integer(self):
        self.stream.set_stream("100")
        self.obj = self.reader.read_from_stream(self.stream)
        self.output_stream = self.printer.print_scheme(obj)
        

if __name__ == '__main__':
    unittest.main()
