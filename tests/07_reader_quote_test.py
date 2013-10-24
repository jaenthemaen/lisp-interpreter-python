import unittest
from repl import *
from scheme_objects.scheme_quote import SchemeQuote
import scheme_exceptions.reader_exceptions as readerEx


class ReaderQuoteTestCase(unittest.TestCase):
    def setUp(self):
        self.stream = string_stream.StringStream()
        self.reader = reader.Reader()

    def test_simple_quote(self):
        self.stream.set_stream("'(a b c d e f g)")
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeQuote))

    def test_nested_quote(self):
        self.stream.set_stream("(x (a '(a b c d e f g)))")
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result.cdr.car.cdr.car, SchemeQuote))

    def test_malformed_quoted_list(self):
        with self.assertRaises(readerEx.MalformedListException) as cm:
            self.stream.set_stream('10   123)')
            self.reader.read_from_stream(self.stream)


if __name__ == '__main__':
    unittest.main()
