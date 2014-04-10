from scheme_objects import *
from scheme_exceptions.evaluator_exceptions import *
import printer
# import utilities
import scheme_builtins

global_env = None
output_stream = None


def evaluate(ast, out):
    global output_stream
    global global_env
    output_stream = out

    if global_env is None:
        global_env = SchemeEnvironment(None)
        scheme_builtins.register_builtins(global_env)
        # TODO std lib loading should be done here

    print_cont = SchemeContinuation(None, None, print_result, None, [SchemeVoid()], None)
    eval_cont = SchemeContinuation(print_cont, global_env, eval_top, ast, None, 0)

    current_cont = eval_cont

    while current_cont is not None:
        current_cont = current_cont.function(current_cont)


def eval_top(cont):
    ast = cont.ast
    if ast.is_scheme_cons():
        return SchemeContinuation(cont.parent_cont, cont.env, prepare_eval, ast, [None] * ast.cdr.list_length(), cont.ret_val)
    else:
        cont.parent_cont.args[cont.ret_val] = cont.ast

    return cont.parent_cont


def eval_static(cont):
    if cont.ast.isSchemeCons:
        # evaluate car!
        pass
    elif cont.ast.isSchemeNumber:
        cont.parent_cont.ret_val = cont.ast
    return cont.parent_cont


# TODO prepare function --> symbol lookup
# muss cont bauen fuer eval_func und eval_args
def prepare_eval(cont):
    # lookup function definition
    symbol = cont.ast.car

    if symbol.is_scheme_symbol():
        func = cont.env.get_binding(symbol.name)
    else:
        return SchemeContinuation(cont.parent_cont, cont.env, eval_static, cont.ast.car, cont.args, cont.evaled_args_count)

    # TODO check if func is a function. if not... it is a list?
    # for now it is the same.
    if func.is_scheme_builtin() or func.is_scheme_lambda() or func.is_scheme_lambda():
        # TODO is there a differentiatiion between lamda & builtin? lambda needs an env maybe?
        # check if arguments count matches!
        if func.args_count != 0 and func.args_count != cont.args.length:
            raise ArgumentsCountNotMatchingException()

        # now eval the args:
        return SchemeContinuation(cont.parent_cont, cont.env, eval_args, cont.ast, cont.args, 0)


def eval_function(cont):
    func = cont.env.get_binding(cont.ast.car.name)
    cont.parent_cont.args[cont.ret_val] = func.func(cont.args)
    return cont.parent_cont


# TODO complete!
def eval_args(cont):
    if cont.evaled_args_count >= len(cont.args):
        return SchemeContinuation(cont.parent_cont, cont.env, eval_function, cont.ast, cont.args, cont.evaled_args_count)
    else:
        return SchemeContinuation(cont.parent_cont, cont.env, eval_top, cont.ast.cdr, cont.args, cont.evaled_args_count)


def print_result(cont):
    global output_stream
    printer.print_scheme_object(cont.args[0], output_stream)
    return None
