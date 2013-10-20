__author__ = 'jan'

import unittest
from repl import *
from scheme_objects.scheme_string import SchemeString
from scheme_objects.scheme_cons import SchemeCons
from scheme_objects.scheme_float import SchemeFloat


class ReaderStringTestCase(unittest.TestCase):

    def setUp(self):
        self.stream = stringstream.Stringstream()
        self.reader = reader.Reader()

    def test_single_string(self):
        self.stream.set_stream('"ouuuladidadida"')
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeString))
        self.assertEqual(result.content, "ouuuladidadida")

    def test_string_with_spaces(self):
        self.stream.set_stream('    "mic check one two one two!"')
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeString))
        self.assertEqual(result.content, "mic check one two one two!")

    def test_string_in_cons(self):
        self.stream.set_stream(' ( "mic check one two one two!" 123.45)')
        result = self.reader.read_from_stream(self.stream)
        self.assertTrue(isinstance(result, SchemeCons))
        self.assertEqual(result.car.content, "mic check one two one two!")
        self.assertTrue(isinstance(result.car, SchemeString))
        self.assertTrue(isinstance(result.cdr.car, SchemeFloat))
        self.assertEqual(result.cdr.car.value, 123.45)



if __name__ == '__main__':
    unittest.main()
