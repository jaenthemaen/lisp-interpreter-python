from scheme_objects import  SchemeObject, SchemeContinuation, SchemeEnvironment

class Evaluator(object):
    """ dat eval """

    def __init__ (self):
        self.global_env = SchemeEnvironment()
        self.load_std_lib()

    def evaluate(self, ast, env=None):
        """
        responsible for evaluating parsed code.
        returning evaluated expressions and symbols.
        """

        # if no env is passed, use globalEnv!
        if env is None:
            env = self.global_env

        if ast.is_scheme_symbol():
            return env.get_binding(ast)
        elif not ast.is_scheme_cons():
            return self.eval_static(ast)
        else:
            return self.eval_function(ast.car, ast.cdr, env)

        return ast


    def eval_static(self, ast, cont, env):
        if cont.ast.isSchemeCons:
            # evaluate car!
            pass
        elif cont.ast.isSchemeNumber:
            cont.parent_cont.ret_val = cont.ast
        return cont.parent_cont

    def eval_function(self):
        pass

    def print_result(cont):
        print cont.arg[0]
        return

    def load_std_lib(self):
        pass
