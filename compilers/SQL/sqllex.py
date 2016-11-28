
from ply import *


keywords = (
    'SELECT', 'FROM', 'INSERT', 'COUNT', 'AS', 'LIMIT', 'ORDER_BY', 'DIRECTION', 'WHERE', 'OR', 'AND'
)

tokens = keywords + (
    'ID', 'WILD', 'SEMI', 'COMMA', 'INT', 'LPAREN', 'RPAREN', 'EQUALS', 'STRING', 'LT', 'LE', 'GT', 'GE', 'NE'
)

t_ignore = ' \t\n'

def t_ORDER_BY(t):
    r'(?i)ORDER\s+BY'
    return t

def t_OR(t):
    r'(?i)\s+OR\s+'
    return t

def t_AND(t):
    r'(?i)\s+AND\s+'
    return t

def t_WHERE(t):
    r'(?i)WHERE'
    return t

def t_DIRECTION(t):
    r'(?i)(ASC|DESC)'
    return t

def t_LIMIT(t):
    r'(?i)LIMIT'
    return t

def t_COUNT(t):
    r'(?i)COUNT'
    return t

def t_AS(t):
    r'(?i)AS'
    return t

def t_SELECT(t):
    r'(?i)SELECT'
    return t

def t_FROM(t):
    r'(?i)FROM'
    return t

def t_INSERT(t):
    r'(?i)INSERT'
    return t

def t_ID(t):
    r'[a-zA-Z][a-zA-Z0-9_-]*'
    if t.value.upper() in keywords:
        t.type = t.value.upper()
    return t

t_WILD = r'\*'
t_SEMI = r';'
t_COMMA = r'\,'
t_INT = r'\d+'
t_EQUALS = r'='
t_LPAREN = r'\('
t_RPAREN = r'\)'
t_STRING = r'\'.*?\''

t_LT = r'<'
t_LE = r'<='
t_GT = r'>'
t_GE = r'>='
t_NE = r'(<>|!=)'
#

# t_PLUS = r'\+'
# t_MINUS = r'-'
#
# t_POWER = r'\^'
# t_DIVIDE = r'/'


#

# t_FLOAT = r'((\d*\.\d+)(E[\+-]?\d+)?|([1-9]\d*E[\+-]?\d+))'


def t_error(t):
    print("Illegal character %s" % t.value[0])
    t.lexer.skip(1)

lex.lex(debug=0)
