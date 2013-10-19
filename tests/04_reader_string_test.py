__author__ = 'jan'

import unittest
from repl import *
from scheme_objects.scheme_string import SchemeString


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


if __name__ == '__main__':
    unittest.main()
