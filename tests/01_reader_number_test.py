import unittest
from repl import *
from scheme_objects.scheme_integer import SchemeInteger
from scheme_objects.scheme_float import SchemeFloat
from scheme_objects.scheme_symbol import SchemeSymbol
from scheme_objects.scheme_string import SchemeString


class TestReaderFunctions(unittest.TestCase):

    def setUp(self):
        self.stream = string_stream.StringStream()
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

    def test_integer_symbol_separation(self):
        self.stream.set_stream("123abcde")
        self.obj =self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(self.obj, SchemeSymbol))
        self.assertEqual(self.obj.name, "123abcde")

    def test_integer_leading_zeros(self):
        self.stream.set_stream("0000000132")
        self.obj = self.reader.read_from_stream(self.stream)
        self.assertEqual(self.obj.value, 132)

    def test_float_parsing(self):
        self.stream.set_stream("1234.567")
        self.obj = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(self.obj, SchemeFloat))

    def test_float_parsing_2(self):
        self.stream.set_stream("1234.")
        self.obj = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(self.obj, SchemeFloat))


    def test_float_value(self):
        self.stream.set_stream("1234.567")
        self.obj = self.reader.read_from_stream(self.stream)
        self.assertEqual(self.obj.value, 1234.567)

    def test_float_value_double_point_error(self):
        self.stream.set_stream("123.123.123")
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeSymbol))
        self.assertEqual(result.name, "123.123.123")

    def test_floaty_symbol_in_nested_list(self):
        self.stream.set_stream('(123.123.123("a" test-test))')
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result.car, SchemeSymbol))
        print result.cdr.car.car.__class__.__name__
        self.assertTrue(isinstance(result.cdr.car.car, SchemeString))
        self.assertTrue(isinstance(result.cdr.car.cdr.car, SchemeSymbol))
        self.assertEqual(result.car.name, "123.123.123")
        self.assertEqual(result.cdr.car.car.content, "a")


if __name__ == '__main__':
    unittest.main()
