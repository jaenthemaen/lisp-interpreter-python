__author__ = 'jan'

import unittest
import reader, printer, evaluator, utilities
from scheme_objects import *


class ReaderSymbolTestCase(unittest.TestCase):

    def setUp(self):
        self.stream = utilities.StringStream()

    def test_single_symbol(self):
        self.stream.set_stream("blahdida")
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeSymbol))

    def test_single_symbol_plus(self):
        self.stream.set_stream("+")
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeSymbol))

    def test_single_symbol_with_spaces(self):
        self.stream.set_stream("      my_function+### ")
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeSymbol))
        self.assertEqual(result.name, "my_function+###")

    def test_symbol_in_cons(self):
        self.stream.set_stream("(define-dat-shite 15.12345)")
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeCons))
        self.assertTrue(isinstance(result.car, SchemeSymbol))
        self.assertTrue(isinstance(result.cdr.car, SchemeFloat))
        self.assertEqual(result.car.name, "define-dat-shite")

    def test_symbol_with_leading_digits(self):
        self.stream.set_stream("123asdfg")
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeSymbol))
        self.assertEqual(result.name, "123asdfg")

if __name__ == '__main__':
    unittest.main()
