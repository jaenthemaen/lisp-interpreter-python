__author__ = 'jan'

import unittest
from repl import *
from scheme_objects.scheme_integer import SchemeInteger
from scheme_objects.scheme_float import SchemeFloat
from scheme_objects.scheme_nil import SchemeNil
from scheme_objects.scheme_cons import SchemeCons


class MyTestCase(unittest.TestCase):

    def setUp(self):
        self.stream = string_stream.StringStream()
        self.reader = reader.Reader()

    def test_empty_list(self):
        self.stream.set_stream('()')
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeNil))

    def test_empty_list_with_spaces(self):
        self.stream.set_stream('(         )')
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeNil))

    def test_list_with_single_item(self):
        self.stream.set_stream('(     10   )')
        result = self.reader.read_from_stream(self.stream)
        self.assertFalse(isinstance(result, SchemeNil))
        self.assertTrue(isinstance(result, SchemeCons))
        self.assertTrue(isinstance(result.car, SchemeInteger))

    def test_list_with_two_items(self):
        self.stream.set_stream('(     10   123.4   )')
        result = self.reader.read_from_stream(self.stream)
        self.assertFalse(isinstance(result, SchemeNil))
        self.assertTrue(isinstance(result, SchemeCons))
        self.assertTrue(isinstance(result.cdr, SchemeCons))
        self.assertTrue(isinstance(result.car, SchemeInteger))
        self.assertTrue(isinstance(result.cdr.car, SchemeFloat))


if __name__ == '__main__':
    unittest.main()
