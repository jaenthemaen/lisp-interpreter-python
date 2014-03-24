from scheme_objects import SchemeContinuation, SchemeEnvironment

class Evaluator(object):
    """ dat eval """

    def evaluate(self, ast):
        """
        responsible for evaluating parsed code.
        returning evaluated expressions and symbols.
        """

        return ast


    def eval_static(cont):
        if cont.ast.isSchemeNumber:
            cont.parent.args[cont.retValIndex] = cont.ast
        return cont.parent


    def print_result(cont):
        print cont.arg[0]
        return
