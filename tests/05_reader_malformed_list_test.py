__author__ = 'jan'

import unittest
from repl import *
from scheme_objects.scheme_integer import SchemeInteger
from scheme_objects.scheme_float import SchemeFloat
from scheme_objects.scheme_nil import SchemeNil
from scheme_objects.scheme_cons import SchemeCons
import scheme_exceptions.reader_exceptions as readerEx


class MalformedListsTestCase(unittest.TestCase):

    def setUp(self):
        self.stream = string_stream.StringStream()
        self.reader = reader.Reader()
        self.output_stream = string_stream.StringStream()
        self.printer = printer.Printer()

    def test_list_with_two_items_without_closing_bracket(self):
        with self.assertRaises(readerEx.MalformedListException) as cm:
            self.stream.set_stream('(     10   123')
            result = self.reader.read_from_stream(self.stream)
        desired_exception = cm.exception
        self.assertTrue(isinstance(desired_exception, readerEx.MalformedListException))

    def test_list_with_two_items_without_opening_bracket(self):
        with self.assertRaises(readerEx.MalformedListException) as cm:
            self.stream.set_stream('10   123)')
            result = self.reader.read_from_stream(self.stream)
            self.printer.print_scheme_object(result, self.output_stream)
            print self.output_stream.get_stream()

        desired_exception = cm.exception
        self.assertTrue(isinstance(desired_exception, readerEx.MalformedListException))


if __name__ == '__main__':
    unittest.main()
