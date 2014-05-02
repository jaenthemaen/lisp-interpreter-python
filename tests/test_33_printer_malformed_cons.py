import reader, printer, utilities
from scheme_objects import SchemeCons, SchemeInteger, SchemeNil
import unittest


class PrinterMalformedConsTestCase(unittest.TestCase):

    def setUp(self):
        self.input_stream = utilities.StringStream()
        self.output_stream = utilities.StringStream()

    def test_simple_malformed_cons(self):
        parsed = SchemeCons(SchemeInteger(5), SchemeInteger(10))
        printer.print_scheme_object(parsed, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "(5 . 10)")

    def test_nested_malformed_cons(self):
        parsed = SchemeCons(SchemeInteger(1), SchemeCons(SchemeCons(SchemeInteger(5), SchemeInteger(10))
                                                         , SchemeNil()))
        printer.print_scheme_object(parsed, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "(1 (5 . 10))")

    # TODO when cons function works, check with real objects!

if __name__ == '__main__':
    unittest.main()