Definitions.

R_PAREN    = \)
L_PAREN    = \(
COMMA      = ,
FLOAT = (\+|\-)?(\.[0-9]+|[0-9]+\.[0-9]+|[0-9]+\.)(E(\+|\-)?[0-9]+)?
INT   = (\+|\-)?[0-9]+

KEYWORD_DIMENSION = DIMENSION
KEYWORD_EQUIVALENCE = EQUIVALENCE
KEYWORD_IF = IF
KEYWORD_GO_TO = GO\sTO
KEYWORD_ASSIGN = ASSIGN
KEYWORD_TO = TO
KEYWORD_DO = DO
KEYWORD_FORMAT = FORMAT
KEYWORD_READ = READ
KEYWORD_READ_INPUT_TAPE = READ\sINPUT\sTAPE
KEYWORD_WRITE = WRITE
KEYWORD_WRITE_OUTPUT_TAPE = WRITE\sOUTPUT\sTAPE
KEYWORD_PRINT = PRINT
KEYWORD_PUNCH = PUNCH
KEYWORD_READ_TAPE = READ\sTAPE
KEYWORD_READ_DRUM = READ\sDRUM
KEYWORD_WRITE_TAPE = WRITE\sTAPE
KEYWORD_WRITE_DRUM = WRITE\sDRUM
KEYWORD_END_FILE = END\sFILE
KEYWORD_REWIND = REWIND
KEYWORD_BACKSPACE = BACKSPACE
KEYWORD_PAUSE = PAUSE
KEYWORD_STOP = STOP
KEYWORD_CONTINUE = CONTINUE
KEYWORD_FREQUENCY = FREQUENCY

CUSTOM_KEYWORD_STATEMENT = S([0-9]+)

OP_ASSIGN = \=
OP_ADD = \+
OP_SUB = \-
OP_DIV = \/
OP_MULT = \*
OP_NEWLINE = [\n]

WHITESPACE = [\s\t\r]
IDENTIFIER = [A-Z][A-Z0-9]*

Rules.

{R_PAREN}   : {token, {')', TokenLine}}.
{L_PAREN}   : {token, {'(', TokenLine}}.
{COMMA}     : {token, {',', TokenLine}}.
{FLOAT}   : {token, {float, TokenLine, TokenChars}}.
{INT}   : {token, {int, TokenLine, TokenChars}}.


{KEYWORD_DIMENSION} : {token, {'DIMENSION', TokenLine}}.
{KEYWORD_EQUIVALENCE} : {token, {'EQUIVALENCE', TokenLine}}.
{KEYWORD_IF} : {token, {'IF', TokenLine}}.
{KEYWORD_GO_TO} : {token, {'GO TO', TokenLine}}.
{KEYWORD_ASSIGN} : {token, {'ASSIGN', TokenLine}}.
{KEYWORD_TO} : {token, {'TO', TokenLine}}.
{KEYWORD_DO} : {token, {'DO', TokenLine}}.
{KEYWORD_FORMAT} : {token, {'FORMAT', TokenLine}}.
{KEYWORD_READ} : {token, {'READ', TokenLine}}.
{KEYWORD_READ_INPUT_TAPE} : {token, {'READ INPUT TAPE', TokenLine}}.
{KEYWORD_WRITE} : {token, {'WRITE', TokenLine}}.
{KEYWORD_WRITE_OUTPUT_TAPE} : {token, {'WRITE OUTPUT TAPE', TokenLine}}.
{KEYWORD_PRINT} : {token, {'PRINT', TokenLine}}.
{KEYWORD_PUNCH} : {token, {'PUNCH', TokenLine}}.
{KEYWORD_READ_TAPE} : {token, {'READ TAPE', TokenLine}}.
{KEYWORD_READ_DRUM} : {token, {'READ DRUM', TokenLine}}.
{KEYWORD_WRITE_TAPE} : {token, {'WRITE TAPE', TokenLine}}.
{KEYWORD_WRITE_DRUM} : {token, {'WRITE DRUM', TokenLine}}.
{KEYWORD_END_FILE} : {token, {'END FILE', TokenLine}}.
{KEYWORD_REWIND} : {token, {'REWIND', TokenLine}}.
{KEYWORD_BACKSPACE} : {token, {'BACKSPACE', TokenLine}}.
{KEYWORD_PAUSE} : {token, {'PAUSE', TokenLine}}.
{KEYWORD_STOP} : {token, {'STOP', TokenLine}}.
{KEYWORD_CONTINUE} : {token, {'CONTINUE', TokenLine}}.
{KEYWORD_FREQUENCY} : {token, {'FREQUENCY', TokenLine}}.

{CUSTOM_KEYWORD_STATEMENT} : {token, {'STATEMENT', TokenLine, TokenChars}}.

{OP_ASSIGN} : {token, {'=', TokenLine}}.
{OP_ADD} : {token, {'+', TokenLine}}.
{OP_MULT} : {token, {'*', TokenLine}}.
{OP_DIV} : {token, {'/', TokenLine}}.
{OP_SUB} : {token, {'-', TokenLine}}.
{OP_NEWLINE} : {token, {newline, TokenLine}}.

{WHITESPACE}+ : skip_token.

{IDENTIFIER}   : {token, {identifier, TokenLine, TokenChars}}.

Erlang code.
