Definitions.

R_PAREN    = \)
L_PAREN    = \(
COMMA      = ,
SEMI      = \;
INT   = [0-9]+

KEYWORD_IF = IF
KEYWORD_ELSE = ELSE
KEYWORD_THEN = THEN
KEYWORD_FOR = FOR
KEYWORD_TO = TO
KEYWORD_NEXT = NEXT
KEYWORD_WHILE = WHILE
KEYWORD_WEND = WEND
KEYWORD_REPEAT = REPEAT
KEYWORD_UNTIL = UNTIL
KEYWORD_DO = DO
KEYWORD_LOOP = LOOP
KEYWORD_GOTO = GOTO
KEYWORD_GOSUB = GOSUB
KEYWORD_ON = ON
KEYWORD_DEF = DEF
KEYWORD_INPUT = INPUT
KEYWORD_PRINT = PRINT
KEYWORD_LET = LET
KEYWORD_END = END

OP_ASSIGN = \=
OP_ADD = \+
OP_SUB = \-
OP_DIV = \/
OP_MULT = \*
OP_OR = OR
OP_AND = AND
OP_NEWLINE = [\n]
WHITESPACE = [\s\t\r]
IDENTIFIER = [a-z]\$
STRING = "[^"]*"

Rules.

{R_PAREN}   : {token, {')', TokenLine}}.
{L_PAREN}   : {token, {'(', TokenLine}}.
{COMMA}     : {token, {',', TokenLine}}.
{SEMI}     : {token, {';', TokenLine}}.
{INT}   : {token, {int, TokenLine, TokenChars}}.


{KEYWORD_IF} : {token, {'IF', TokenLine}}.
{KEYWORD_ELSE} : {token, {'ELSE', TokenLine}}.
{KEYWORD_THEN} : {token, {'THEN', TokenLine}}.
{KEYWORD_FOR} : {token, {'FOR', TokenLine}}.
{KEYWORD_TO} : {token, {'TO', TokenLine}}.
{KEYWORD_NEXT} : {token, {'NEXT', TokenLine}}.
{KEYWORD_WHILE} : {token, {'WHILE', TokenLine}}.
{KEYWORD_WEND} : {token, {'WEND', TokenLine}}.
{KEYWORD_REPEAT} : {token, {'REPEAT', TokenLine}}.
{KEYWORD_UNTIL} : {token, {'UNTIL', TokenLine}}.
{KEYWORD_DO} : {token, {'DO', TokenLine}}.
{KEYWORD_LOOP} : {token, {'LOOP', TokenLine}}.
{KEYWORD_GOTO} : {token, {'GOTO', TokenLine}}.
{KEYWORD_GOSUB} : {token, {'GOSUB', TokenLine}}.
{KEYWORD_ON} : {token, {'ON', TokenLine}}.
{KEYWORD_DEF} : {token, {'DEF', TokenLine}}.
{KEYWORD_INPUT} : {token, {'INPUT', TokenLine}}.
{KEYWORD_PRINT} : {token, {'PRINT', TokenLine}}.
{KEYWORD_LET} : {token, {'LET', TokenLine}}.
{KEYWORD_END} : {token, {'END', TokenLine}}.

{OP_ASSIGN} : {token, {'=', TokenLine}}.
{OP_ADD} : {token, {'+', TokenLine}}.
{OP_MULT} : {token, {'*', TokenLine}}.
{OP_DIV} : {token, {'/', TokenLine}}.
{OP_SUB} : {token, {'-', TokenLine}}.
{OP_NEWLINE} : {token, {newline, TokenLine}}.

{WHITESPACE}+ : skip_token.
{IDENTIFIER}   : {token, {identifier, TokenLine, TokenChars}}.
{STRING}   : {token, {string, TokenLine, TokenChars}}.

Erlang code.
