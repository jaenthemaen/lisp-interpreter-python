__author__ = 'jan'

import unittest
import reader, printer, evaluator, utilities
import scheme_exceptions.reader_exceptions as readerEx


class MalformedListsTestCase(unittest.TestCase):

    def setUp(self):
        self.stream = utilities.StringStream()
        self.reader = reader.Reader()

    def test_misplaced_parenthesis(self):
        with self.assertRaises(readerEx.MalformedListException) as cm:
            self.stream.set_stream(')(')
            self.reader.read_from_stream(self.stream)

        desired_exception = cm.exception
        self.assertTrue(isinstance(desired_exception, readerEx.MalformedListException))

    def test_misplaced_inner_parenthesis(self):
        with self.assertRaises(readerEx.MalformedListException) as cm:
            self.stream.set_stream('(()))')
            self.reader.read_from_stream(self.stream)

        desired_exception = cm.exception
        self.assertTrue(isinstance(desired_exception, readerEx.MalformedListException))

if __name__ == '__main__':
    unittest.main()