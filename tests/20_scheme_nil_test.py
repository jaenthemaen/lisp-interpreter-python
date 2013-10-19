__author__ = 'jan'

import unittest
from scheme_objects.scheme_nil import SchemeNil
from scheme_objects.scheme_number import SchemeNumber

class SchemeNilTestCase(unittest.TestCase):

    def setUp(self):
        self.instance_1 = None
        self.instance_2 = None

    def test_singleton(self):
        self.instance_1 = SchemeNil()
        self.instance_2 = SchemeNil()
        self.assertTrue(self.instance_1 == self.instance_2, "Singleton created multiple times")

    def test_singleton_2(self):
        self.instance_1 = SchemeNil()
        self.instance_2 = SchemeNumber(123)
        self.assertFalse(self.instance_1 == self.instance_2, """Instances are the same,
                                                           even though one is SchemeNumber
                                                           and the other is SchemeNil!""")

if __name__ == '__main__':
    unittest.main()
