__author__ = 'jan'
from repl import *
import unittest


class PrinterQupteTestCase(unittest.TestCase):

    def setUp(self):
        self.input_stream = string_stream.StringStream()
        self.output_stream = string_stream.StringStream()
        self.reader = reader.Reader()
        self.printer = printer.Printer()

    def test_integer_quote(self):
        self.input_stream.set_stream("'10")
        parsed = self.reader.read_from_stream(self.input_stream)
        self.printer.print_scheme_object(parsed, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "10")

    def test_list_quote(self):
        self.input_stream.set_stream("'(a b c d e)")
        parsed = self.reader.read_from_stream(self.input_stream)
        self.printer.print_scheme_object(parsed, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "(a b c d e)")

    def test_nested_list_quote(self):
        self.input_stream.set_stream("'(a b (898 123.67 \"abcde\") c d e)")
        parsed = self.reader.read_from_stream(self.input_stream)
        self.printer.print_scheme_object(parsed, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "(a b (898 123.67 \"abcde\") c d e)")

if __name__ == '__main__':
    unittest.main()
