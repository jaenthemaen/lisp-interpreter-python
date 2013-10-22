import unittest
from repl import *

class TestStringstreamFunctions(unittest.TestCase):

    def setUp(self):
        self.stream = string_stream.StringStream()

    def test_first_element(self):
        self.stream.set_stream("abcde")
        self.assertEqual(self.stream.read_char(), "a")
        self.assertEqual(self.stream.stream, "bcde")

    def test_peek_char(self):
        self.stream.set_stream("abcde")
        self.assertEqual(self.stream.peek_char(), "a")
        self.assertEqual(self.stream.stream, "abcde")

if __name__ == '__main__':
    unittest.main()
