from scheme_objects import *
import scheme_exceptions.reader_exceptions as reader_ex
from utilities import StringStream

# responsible for reading and parsing incoming code

def read_from_stream(stream):

    if not stream.preprocessed:
        # not sure which behaves best for large source files
        # TODO: test with large streams!
        # preprocess_stream_content(deepcopy(stream))
        preprocess_stream_content(StringStream(stream.stream))
        stream.preprocessed = True

    stream.skip_spaces()
    pch = stream.peek_char()

    if pch.isdigit():
        return read_number_from_stream(stream)

    if pch == '"':
        stream.read_char()
        return read_string_from_stream(stream)

    if pch == "'":
        stream.read_char()
        return SchemeCons(SchemeSymbol('quote')
                          , SchemeCons(read_from_stream(stream), SchemeNil()))

    if pch == "-":
        return read_number_from_stream(stream)

    if pch == "(":
        stream.read_char()
        return read_list_from_stream(stream)
    #TODO: pass comments!

    return read_symbol_from_stream(stream)


def preprocess_stream_content(stream):
    paren_opened = False
    paren_opened_count = 0
    paren_closed_count = 0

    current_char = stream.read_char()

    while current_char is not None:
        if current_char is '(':
            paren_opened_count += 1
            paren_opened = True

        if current_char is ')':
            if not paren_opened:
                raise reader_ex.MalformedListException(
                    "Met closing parenthesis without matching opening parenthesis.")
            else:
                paren_closed_count += 1
                if paren_closed_count == paren_opened_count:
                    paren_opened = False

        current_char = stream.read_char()

    if paren_closed_count == paren_opened_count:
        return True
    else:
        raise reader_ex.MalformedListException(
            "Parenthesis counts aren't matching! Opened:" + str(paren_opened_count) + ", Closed:" + str(paren_closed_count))


def read_number_from_stream(stream):
    value = ""
    is_float = False

    if stream.peek_char() == "-":
        value += stream.read_char()

    while stream.peek_char() is not None and stream.peek_char().isdigit():
        value += stream.read_char()

    # If the iteration stopped at a '.' it
    # must continue and assume it reads a float value.
    # If another character shows up before whitespace or bracket
    # it is assumed to be a symbol!
    stop_ch = stream.peek_char()

    if stop_ch == '.':
        is_float = True
        value += stream.read_char()

        while stream.peek_char() is not None and stream.peek_char().isdigit():
            value += stream.read_char()

        # checks for both kinds of brackets, spaces and None-Type as legit next chars.
        # right?
        ch = stream.peek_char()
        if ch is not None and ch.isspace() is False and ch is not ')' and ch is not '(':
            stream.set_stream(value + stream.stream)
            return read_symbol_from_stream(stream)
    elif stop_ch is not None and stop_ch != '(' and stop_ch != ')' and stop_ch.isspace() is False:
        stream.set_stream(value + stream.stream, uncheck_preprocessed=True)
        return read_symbol_from_stream(stream)

    if is_float:
        return SchemeFloat(float(value))
    else:
        return SchemeInteger(int(value))


def read_list_from_stream(stream):

    stream.skip_spaces()
    if stream.peek_char() == ')':
        stream.read_char()
        return SchemeNil()
    elif stream.peek_char() is None:
        raise reader_ex.MalformedListException("No matching closing bracket met before EOF!")
    else:
        element = read_from_stream(stream)
        rest_list = read_list_from_stream(stream)
        return SchemeCons(element, rest_list)


def read_symbol_from_stream(stream):
    symbol_name = ""
    pch = stream.peek_char()

    while pch != None and pch != '(' and pch != ')' and pch.isspace() == False:
        symbol_name += pch
        stream.read_char()
        pch = stream.peek_char()

    return SchemeSymbol(symbol_name)


def read_string_from_stream(stream):
    string_content = ""
    escCh = None
    ch = stream.peek_char()

    while ch != None and ch != '"':
        if ch == '\\':
            stream.read_char()
            escCh = stream.peek_char()

            if escCh == 'n':
                string_content += '\n'
            else:
                string_content += escCh
        else:
            string_content += ch
        stream.read_char()
        ch = stream.peek_char()

    if ch == None:
        raise reader_ex.StringUnfinishedException("String didn't end properly with quotes.", string_content)
    elif ch == '"':
        stream.read_char()
        return SchemeString(string_content)
