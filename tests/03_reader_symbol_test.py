__author__ = 'jan'

import unittest
from repl import *
from scheme_objects.scheme_symbol import SchemeSymbol


class ReaderSymbolTestCase(unittest.TestCase):

    def setUp(self):
        self.stream = stringstream.Stringstream()
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


if __name__ == '__main__':
    unittest.main()
