__author__ = 'jan'

import unittest
import reader, printer, evaluator, utilities
from scheme_objects import *


class ReaderSymbolTestCase(unittest.TestCase):

    def setUp(self):
        self.stream = utilities.StringStream()
        self.reader = reader.Reader()

    def test_single_symbol(self):
        self.stream.set_stream("blahdida")
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeSymbol))

    def test_single_symbol_plus(self):
        self.stream.set_stream("+")
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeSymbol))

    def test_single_symbol_with_spaces(self):
        self.stream.set_stream("      my_function+### ")
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeSymbol))
        self.assertEqual(result.name, "my_function+###")

    def test_symbol_in_cons(self):
        self.stream.set_stream("(define-dat-shite 15.12345)")
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeCons))
        self.assertTrue(isinstance(result.car, SchemeSymbol))
        self.assertTrue(isinstance(result.cdr.car, SchemeFloat))
        self.assertEqual(result.car.name, "define-dat-shite")

if __name__ == '__main__':
    unittest.main()
