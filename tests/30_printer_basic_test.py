__author__ = 'jan'

import unittest
import repl as repl
from scheme_objects.scheme_symbol import SchemeSymbol
from scheme_objects.scheme_cons import SchemeCons
from scheme_objects.scheme_float import SchemeFloat


class PrinterBasicTestCase(unittest.TestCase):

    def setUp(self):
        self.reader = repl.reader.Reader()
        self.read_stream = repl.string_stream.StringStream()
        self.printer = repl.printer.Printer()
        self.write_stream = repl.string_stream.StringStream()

    def test_integer(self):
        self.read_stream.set_stream("123")
        result = self.reader.read_from_stream(self.read_stream)
        self.printer.print_scheme_object(result, self.write_stream)
        self.assertEqual(self.write_stream.get_stream(), "123", "instead: " + self.write_stream.get_stream())

    def test_float(self):
        self.read_stream.set_stream("0.34")
        result = self.reader.read_from_stream(self.read_stream)
        self.printer.print_scheme_object(result, self.write_stream)
        self.assertEqual(self.write_stream.get_stream(), "0.34", "instead: " + self.write_stream.get_stream())

    def test_list_with_symbol_and_integer(self):
        self.read_stream.set_stream("(some-variable 12345)")
        result = self.reader.read_from_stream(self.read_stream)
        self.printer.print_scheme_object(result, self.write_stream)
        self.assertEqual(self.write_stream.get_stream(), "(some-variable 12345)", "instead: " + self.write_stream.get_stream())


if __name__ == '__main__':
    unittest.main()
