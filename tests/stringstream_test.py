import unittest
from repl import *

class TestStringstreamFunctions(unittest.TestCase):

    def setUp(self):
        self.stream = stringstream.Stringstream()

    def test_first_element(self):
        self.stream.set_stream("abcde")
        self.assertEqual(self.stream.read_char(), "a")
        self.assertEqual(self.stream.stream, "bcde")

    def test_peek_char(self):
        self.stream.set_stream("abcde")
        self.assertEqual(self.stream.peek_char(), "a")
        self.assertEqual(self.stream.stream, "abcde")

    #     # should raise an exception for an immutable sequence
    #     self.assertRaises(TypeError, random.shuffle, (1,2,3))

    # def test_choice(self):
    #     element = random.choice(self.seq)
    #     self.assertTrue(element in self.seq)

    # def test_sample(self):
    #     with self.assertRaises(ValueError):
    #         random.sample(self.seq, 20)
    #     for element in random.sample(self.seq, 5):
    #         self.assertTrue(element in self.seq)

if __name__ == '__main__':
    unittest.main()
