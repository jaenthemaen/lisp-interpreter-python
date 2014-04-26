from scheme_objects import  SchemeObject, SchemeContinuation, SchemeEnvironment, SchemeVoid
import printer
import scheme_builtins

global_env = None
output_stream = None


def evaluate(ast, out):
    global output_stream
    global global_env

    if global_env is None:
        global_env = SchemeEnvironment(None)
        scheme_builtins.register_builtins(global_env)
        # std lib loading should be done here
    output_stream = out

    # 1. neue cinuation
    print_c = SchemeContinuation(pc=None, env=None, func=print_result, ast=None, args=[None], ret_index=None)
    eval_c = SchemeContinuation(pc=print_c, env=global_env, func=eval, ast=ast, args=None, ret_index=0)

    current_c = eval_c

    while current_c is not None:
        current_c = current_c.func(current_c)


def eval(c):
    # returns unevaled ast
    ast = c.ast
    if ast.is_scheme_cons():
        return SchemeContinuation(pc=c.pc, env=c.env, func=eval_function, ast=c.ast,
                                  args=[None] * c.ast.cdr.list_length(), ret_index=0)
    else:
        c.pc.args[c.ret_index] = c.ast

    return c.pc


def eval_function(c):
    # TODO check for number of args
    func = c.env.get_binding(c.ast.car.name)
    curr = c.ast.cdr
    arg_len = 0
    while curr.is_scheme_cons():
        c.args[arg_len] = curr.car
        arg_len += 1
        curr = curr.cdr

    c.pc.args[c.ret_index] = func.func(c.args)
    return c.pc


def eval_args(c):
    if c.args_count >= c.args.length:
        return c.pc


def print_result(c):
    global output_stream
    printer.print_scheme_object(c.args[0], output_stream)
    return None
