import reader, printer, evaluator, utilities
import unittest


class PrinterQupteTestCase(unittest.TestCase):

    def setUp(self):
        self.input_stream = utilities.StringStream()
        self.output_stream = utilities.StringStream()


    def test_unevaled_integer_quote(self):
        self.input_stream.set_stream("'10")
        parsed = reader.read_from_stream(self.input_stream)
        printer.print_scheme_object(parsed, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "'10")

    def test_unevaled_list_quote(self):
        self.input_stream.set_stream("'(a b c d e)")
        parsed = reader.read_from_stream(self.input_stream)
        printer.print_scheme_object(parsed, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "'(a b c d e)")

    def test_unevaled_nested_list_quote(self):
        self.input_stream.set_stream("'(a b (898 123.67 \"abcde\") c d e)")
        parsed = reader.read_from_stream(self.input_stream)
        printer.print_scheme_object(parsed, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "'(a b (898 123.67 \"abcde\") c d e)")

if __name__ == '__main__':
    unittest.main()
