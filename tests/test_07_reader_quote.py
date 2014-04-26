import unittest
import reader, printer, evaluator, utilities
from scheme_objects import *
import scheme_exceptions.reader_exceptions as readerEx


class ReaderQuoteTestCase(unittest.TestCase):
    def setUp(self):
        self.stream = utilities.StringStream()
        self.output_stream = utilities.StringStream()

    def test_simple_quote(self):
        self.stream.set_stream("'(a b c d e f g)")
        result = reader.read_from_stream(self.stream)
        printer.print_scheme_object(result, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "(quote (a b c d e f g))")

    def test_nested_quote(self):
        self.stream.set_stream("(x (a '(a b c d e f g)))")
        result = reader.read_from_stream(self.stream)
        printer.print_scheme_object(result, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "(x (a (quote (a b c d e f g))))")

    def test_malformed_quoted_list(self):
        with self.assertRaises(readerEx.MalformedListException) as cm:
            self.stream.set_stream('10   123)')
            reader.read_from_stream(self.stream)


if __name__ == '__main__':
    unittest.main()
