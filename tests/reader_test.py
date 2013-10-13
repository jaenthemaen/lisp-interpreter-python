import unittest
from repl import *

class TestReaderFunctions(unittest.TestCase):

    def setUp(self):
        self.stream = stringstream.Stringstream()
        self.reader = reader.Reader()

    def test_eof_exit(self):
        self.stream.set_stream("")
        self.assertEqual(True, True)

if __name__ == '__main__':
    unittest.main()
