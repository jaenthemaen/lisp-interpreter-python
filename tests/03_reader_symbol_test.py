__author__ = 'jan'

import unittest
from repl import *
from scheme_objects.scheme_symbol import SchemeSymbol
from scheme_objects.scheme_cons import SchemeCons
from scheme_objects.scheme_float import SchemeFloat


class ReaderSymbolTestCase(unittest.TestCase):

    def setUp(self):
        self.stream = string_stream.StringStream()
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
