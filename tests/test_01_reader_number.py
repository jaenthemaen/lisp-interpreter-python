import unittest
import reader, printer, evaluator, utilities
from scheme_objects import *


class TestReaderFunctions(unittest.TestCase):

    def setUp(self):
        self.stream = utilities.StringStream()
        self.obj = None
        self.output_stream = ""

    def test_integer_parsing(self):
        self.stream.set_stream("100")
        self.obj = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(self.obj, SchemeInteger))

    def test_integer_value(self):
        self.stream.set_stream("132")
        self.obj = reader.read_from_stream(self.stream)
        self.assertEqual(self.obj.value, 132)

    def test_integer_symbol_separation(self):
        self.stream.set_stream("123abcde")
        self.obj = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(self.obj, SchemeSymbol))
        self.assertEqual(self.obj.name, "123abcde")

    def test_integer_leading_zeros(self):
        self.stream.set_stream("0000000132")
        self.obj = reader.read_from_stream(self.stream)
        self.assertEqual(self.obj.value, 132)

    def test_float_parsing(self):
        self.stream.set_stream("1234.567")
        self.obj = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(self.obj, SchemeFloat))

    def test_float_parsing_2(self):
        self.stream.set_stream("1234.")
        self.obj = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(self.obj, SchemeFloat))


    def test_float_value(self):
        self.stream.set_stream("1234.567")
        self.obj = reader.read_from_stream(self.stream)
        self.assertEqual(self.obj.value, 1234.567)

    def test_float_value_double_point_error(self):
        self.stream.set_stream("123.123.123")
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeSymbol))
        self.assertEqual(result.name, "123.123.123")

    def test_floaty_symbol_in_nested_list(self):
        self.stream.set_stream('(123.123.123("a" test-test))')
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result.car, SchemeSymbol))
        self.assertTrue(isinstance(result.cdr.car.car, SchemeString))
        self.assertTrue(isinstance(result.cdr.car.cdr.car, SchemeSymbol))
        self.assertEqual(result.car.name, "123.123.123")
        self.assertEqual(result.cdr.car.car.content, "a")

    def test_negative_number(self):
        self.stream.set_stream("-1")
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeInteger))
        self.assertEqual(result.value, -1)

    def test_negative_float_number(self):
        self.stream.set_stream("-1.0")
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeFloat))
        self.assertEqual(result.value, -1.0)



if __name__ == '__main__':
    unittest.main()
