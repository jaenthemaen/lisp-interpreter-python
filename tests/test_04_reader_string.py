__author__ = 'jan'

import unittest
import reader, printer, evaluator, utilities
from scheme_objects import *


class ReaderStringTestCase(unittest.TestCase):

    def setUp(self):
        self.stream = utilities.StringStream()

    def test_single_string(self):
        self.stream.set_stream('"ouuuladidadida"')
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeString))
        self.assertEqual(result.content, "ouuuladidadida")

    def test_string_with_spaces(self):
        self.stream.set_stream('    "mic check one two one two!"')
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeString))
        self.assertEqual(result.content, "mic check one two one two!")

    def test_string_in_cons(self):
        self.stream.set_stream(' ( "mic check one two one two!" 123.45)')
        result = reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeCons))
        self.assertEqual(result.car.content, "mic check one two one two!")
        self.assertTrue(isinstance(result.car, SchemeString))
        self.assertTrue(isinstance(result.cdr.car, SchemeFloat))
        self.assertEqual(result.cdr.car.value, 123.45)



if __name__ == '__main__':
    unittest.main()
