__author__ = 'jan'

import unittest
import reader, printer, evaluator, utilities


class EvalBasicArithmeticTestCase(unittest.TestCase):

    def setUp(self):
        self.input_stream = utilities.StringStream()
        self.output_stream = utilities.StringStream()
        self.reader = reader.Reader()
        self.printer = printer.Printer()
        self.evaluator = evaluator.Evaluator()

    def test_addition_with_naturals(self):
        self.input_stream.set_stream("(+ 2 3)")
        parsed = self.reader.read_from_stream(self.input_stream)
        evaluated = self.evaluator.evaluate(parsed)
        self.printer.print_scheme_object(evaluated, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "5")



if __name__ == '__main__':
    unittest.main()
