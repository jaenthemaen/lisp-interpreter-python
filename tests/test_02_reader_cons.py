import unittest
import reader, printer, evaluator, utilities
from scheme_objects import *


class MyTestCase(unittest.TestCase):

    def setUp(self):
        self.stream = utilities.StringStream()

    def test_empty_list(self):
        self.stream.set_stream('()')
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeNil))

    def test_empty_list_with_spaces(self):
        self.stream.set_stream('(         )')
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeNil))

    def test_list_with_single_item(self):
        self.stream.set_stream('(     10   )')
        result = reader.read_from_stream(self.stream)
        self.assertFalse(isinstance(result, SchemeNil))
        self.assertTrue(isinstance(result, SchemeCons))
        self.assertTrue(isinstance(result.car, SchemeInteger))

    def test_list_with_two_items(self):
        self.stream.set_stream('(     10   123.4   )')
        result = reader.read_from_stream(self.stream)
        self.assertFalse(isinstance(result, SchemeNil))
        self.assertTrue(isinstance(result, SchemeCons))
        self.assertTrue(isinstance(result.cdr, SchemeCons))
        self.assertTrue(isinstance(result.car, SchemeInteger))
        self.assertTrue(isinstance(result.cdr.car, SchemeFloat))
        self.assertTrue(isinstance(result.cdr.cdr, SchemeNil))


if __name__ == '__main__':
    unittest.main()
