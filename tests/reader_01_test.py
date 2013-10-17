import unittest
from repl import *
from scheme_objects.scheme_integer import SchemeInteger
from scheme_objects.scheme_float import SchemeFloat


class TestReaderFunctions(unittest.TestCase):

    def setUp(self):
        self.stream = stringstream.Stringstream()
        self.reader = reader.Reader()
        self.printer = printer.Printer()
        self.obj = None
        self.output_stream = ""

    def test_integer_parsing(self):
        self.stream.set_stream("100")
        self.obj = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(self.obj, SchemeInteger))

    def test_integer_value(self):
        self.stream.set_stream("132")
        self.obj = self.reader.read_from_stream(self.stream)
        self.assertEqual(self.obj.value, 132)

    def test_integer_leading_zeros(self):
        self.stream.set_stream("0000000132")
        self.obj = self.reader.read_from_stream(self.stream)
        self.assertEqual(self.obj.value, 132)

if __name__ == '__main__':
    unittest.main()
