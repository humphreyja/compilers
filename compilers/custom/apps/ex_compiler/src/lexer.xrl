Definitions.

R_PAREN    = \)
L_PAREN    = \(
R_BRACE    = \}
L_BRACE    = \{
COMMA      = ,
INT   = [0-9]+

KEYWORD_IF = if
KEYWORD_ELSE = else
KEYWORD_BREAK = break
KEYWORD_WHILE = while
KEYWORD_RETURN = return
KEYWORD_CONTINUE = continue
KEYWORD_CLASS = class
KEYWORD_AND = and
KEYWORD_OR = or
KEYWORD_TYPE = type
KEYWORD_INT = int
KEYWORD_BOOL = bool
KEYWORD_VOID = void
KEYWORD_TRUE = true
KEYWORD_FALSE = false

OP_EQUAL = \=\=
OP_LT_EQ = <\=
OP_GT_EQ = >\=
OP_LT = <
OP_GT = >
OP_NEQ = \!\=
OP_NOT = \!
OP_ASSIGN = \=
OP_ADD = \+
OP_ADD_ASSIGN = \+\=
OP_MULT = \*
OP_MULT_ASSIGN = \*\=
OP_DIV = \/
OP_DIV_ASSIGN = \/\=
OP_SUB = \-
OP_SUB_ASSIGN = \-\=
OP_MOD = \%
OP_MOD_ASSIGN = \%\=
OP_NEWLINE = (\n|;)
OP_QUOTE = \"\"
OP_DOT = \.


WHITESPACE = [\s\t\r]
IDENTIFIER = [a-zA-Z_][a-zA-Z0-9_]*

Rules.

{R_PAREN}   : {token, {')', TokenLine}}.
{L_PAREN}   : {token, {'(', TokenLine}}.
{R_BRACE}   : {token, {'}', TokenLine}}.
{L_BRACE}   : {token, {'{', TokenLine}}.
{COMMA}     : {token, {',', TokenLine}}.
{INT}   : {token, {number, TokenLine, TokenChars}}.

{KEYWORD_IF} : {token, {'if', TokenLine}}.
{KEYWORD_ELSE} : {token, {'else', TokenLine}}.
{KEYWORD_BREAK} : {token, {'break', TokenLine}}.
{KEYWORD_WHILE} : {token, {'while', TokenLine}}.
{KEYWORD_RETURN} : {token, {'return', TokenLine}}.
{KEYWORD_CONTINUE} : {token, {'continue', TokenLine}}.
{KEYWORD_CLASS} : {token, {'class', TokenLine}}.
{KEYWORD_AND} : {token, {'and', TokenLine}}.
{KEYWORD_OR} : {token, {'or', TokenLine}}.
{KEYWORD_TYPE} : {token, {'type', TokenLine}}.
{KEYWORD_INT} : {token, {'int', TokenLine}}.
{KEYWORD_BOOL} : {token, {'bool', TokenLine}}.
{KEYWORD_TRUE} : {token, {'true', TokenLine}}.
{KEYWORD_FALSE} : {token, {'false', TokenLine}}.
{KEYWORD_VOID} : {token, {'void', TokenLine}}.

{OP_EQUAL} : {token, {'==', TokenLine}}.
{OP_LT_EQ} : {token, {'<=', TokenLine}}.
{OP_GT_EQ} : {token, {'>=', TokenLine}}.
{OP_LT} : {token, {'<', TokenLine}}.
{OP_GT} : {token, {'>', TokenLine}}.
{OP_NEQ} : {token, {'!=', TokenLine}}.
{OP_NOT} : {token, {'!', TokenLine}}.
{OP_ASSIGN} : {token, {'=', TokenLine}}.
{OP_ADD} : {token, {'+', TokenLine}}.
{OP_ADD_ASSIGN} : {token, {'+=', TokenLine}}.
{OP_MULT} : {token, {'*', TokenLine}}.
{OP_MULT_ASSIGN} : {token, {'*=', TokenLine}}.
{OP_DIV} : {token, {'/', TokenLine}}.
{OP_DIV_ASSIGN} : {token, {'/=', TokenLine}}.
{OP_SUB} : {token, {'-', TokenLine}}.
{OP_SUB_ASSIGN} : {token, {'-=', TokenLine}}.
{OP_MOD} : {token, {'%', TokenLine}}.
{OP_MOD_ASSIGN} : {token, {'%=', TokenLine}}.
{OP_NEWLINE} : {token, {newline, TokenLine}}.
{OP_QUOTE} : {token, {'"', TokenLine}}.
{OP_DOT} : {token, {'.', TokenLine}}.

{WHITESPACE}+ : skip_token.

{IDENTIFIER}   : {token, {identifier, TokenLine, TokenChars}}.

Erlang code.
