import unittest
import reader, printer, evaluator, utilities
from scheme_exceptions.builtins_exceptions import NotANumberException


class EvalBasicArithmeticTestCase(unittest.TestCase):

    def setUp(self):
        self.input_stream = utilities.StringStream()
        self.output_stream = utilities.StringStream()

    def test_addition_with_naturals(self):
        self.input_stream.set_stream("(+ 2 3)")
        parsed = reader.read_from_stream(self.input_stream)
        evaluator.evaluate(parsed, self.output_stream)
        self.assertEqual(self.output_stream.get_stream(), "5")

    # def test_addition_with_negatives(self):
    #     self.input_stream.set_stream("(+ 15 -30)")
    #     parsed = reader.read_from_stream(self.input_stream)
    #     evaluator.evaluate(parsed, self.output_stream)
    #     self.assertEqual(self.output_stream.get_stream(), "-15")
    #
    # def test_addition_with_floats(self):
    #     self.input_stream.set_stream("(+ 15.3 -30.4)")
    #     parsed = reader.read_from_stream(self.input_stream)
    #     evaluator.evaluate(parsed, self.output_stream)
    #     self.assertEqual(self.output_stream.get_stream(), "-15.1")
    #
    # def test_addition_class_check(self):
    #     with self.assertRaises(NotANumberException) as nan_ex:
    #         self.input_stream.set_stream("(+ 15.3 oooh_la_di_da)")
    #         parsed = reader.read_from_stream(self.input_stream)
    #         evaluator.evaluate(parsed, self.output_stream)
    #     self.assertTrue(isinstance(nan_ex.exception, NotANumberException))
    #
    # def test_multiplication_with_naturals(self):
    #     self.input_stream.set_stream("(* 2 3)")
    #     parsed = reader.read_from_stream(self.input_stream)
    #     evaluator.evaluate(parsed, self.output_stream)
    #     self.assertEqual(self.output_stream.get_stream(), "6")
    #
    # def test_multiplication_with_negatives(self):
    #     self.input_stream.set_stream("(* 15 -3)")
    #     parsed = reader.read_from_stream(self.input_stream)
    #     evaluator.evaluate(parsed, self.output_stream)
    #     self.assertEqual(self.output_stream.get_stream(), "-45")
    #
    # def test_multiplication_with_floats(self):
    #     self.input_stream.set_stream("(* 15.2 -3)")
    #     parsed = reader.read_from_stream(self.input_stream)
    #     evaluator.evaluate(parsed, self.output_stream)
    #     self.assertEqual(self.output_stream.get_stream(), "-45.6")
    #
    # def test_multiplication_class_check(self):
    #     with self.assertRaises(NotANumberException) as nan_ex:
    #         self.input_stream.set_stream("(* 15.3 oooh_la_di_da)")
    #         parsed = reader.read_from_stream(self.input_stream)
    #         evaluator.evaluate(parsed, self.output_stream)
    #     self.assertTrue(isinstance(nan_ex.exception, NotANumberException))

if __name__ == '__main__':
    unittest.main()
