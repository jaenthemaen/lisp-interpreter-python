__author__ = 'jan'

import unittest
import reader, printer, evaluator, utilities
import scheme_exceptions.reader_exceptions as readerEx


class MalformedListsTestCase(unittest.TestCase):

    def setUp(self):
        self.stream = utilities.StringStream()
        self.reader = reader.Reader()
        self.output_stream = utilities.StringStream()
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

        desired_exception = cm.exception
        self.assertTrue(isinstance(desired_exception, readerEx.MalformedListException))


if __name__ == '__main__':
    unittest.main()
