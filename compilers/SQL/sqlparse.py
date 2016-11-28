from ply import *
import sqllex

tokens = sqllex.tokens
precedence = ()

def p_program(p):
    '''program : statement SEMI'''
    p[0] = p[1]

def p_statement_select(p):
    '''statement : SELECT fields FROM table where_opts group_by_opts order_by_opts limit_opts'''
    p[0] = {'type':'SELECT', 'fields':p[2], 'table':p[4],'where': p[5], 'group': p[6], 'order': p[7], 'limit': p[8]}

def p_fields_separate_fields(p):
    '''fields : fields COMMA field
              | field'''
    if len(p) == 2 and p[1]:
        p[0] = [p[1]]
    elif len(p) == 4:
        p[0] = p[1]
        if not p[0]:
            p[0] = []
        if p[3]:
            p[0].append(p[3])

def p_field_wild(p):
    '''field : WILD'''
    p[0] = ['*WILD*']

def p_field_count(p):
    '''field : COUNT LPAREN ID RPAREN
             | COUNT LPAREN WILD RPAREN
             | COUNT LPAREN ID RPAREN AS ID
             | COUNT LPAREN WILD RPAREN AS ID'''
    if len(p) == 7:
        p[0] = ('*COUNT*', p[6])
    else:
        p[0] = ('*COUNT*', 'count')

def p_field_column(p):
    '''field : ID
             | ID AS ID'''
    if len(p) == 2:
        p[0] = ('COLUMN', p[1], p[1])
    elif len(p) == 4:
        p[0] = ('COLUMN', p[1], p[3])

def p_table(p):
    '''table : ID'''
    p[0] = p[1]

def p_where_opts(p):
    '''where_opts : WHERE equalities
                  |'''
    if len(p) == 3:
        p[0] = p[2]
    else:
        p[0] = []

def p_order_by_opts(p):
    '''order_by_opts : ORDER_BY ID
                     | ORDER_BY DIRECTION ID
                     |'''
    if len(p) == 3:
        p[0] = {'asc':False, 'id':p[2]}
    elif len(p) == 4:
        asc = False
        if p[2].upper() == 'ASC':
            asc = True
        p[0] = {'asc':asc, 'id':p[3]}
    else:
        p[0] = {'asc':False, 'id':'id'}

def p_group_by_opts(p):
    '''group_by_opts : '''
    if len(p) == 3:
        p[0] = ('GROUP', p[2])
    else:
        p[0] = []

def p_limit_opts(p):
    '''limit_opts : LIMIT INT
                  |'''
    if len(p) == 3:
        p[0] = int(p[2])
    else:
        p[0] = -1

def p_equalities(p):
    '''equalities : equalities AND equality
                  | equalities OR equality
                  | equality'''
    if len(p) == 2 and p[1]:
        p[0] = [{'logical':'AND', 'equality':p[1]}]
    elif len(p) == 4:
        p[0] = p[1]
        if not p[0]:
            p[0] = []
        if p[3]:
            p[0].append({'logical':p[2].upper(), 'equality':p[3]})

def p_equality_equals(p):
    '''equality : value EQUALS value'''
    p[0] = {'lhs': p[1], 'eval':'EQ', 'rhs': p[3]}

def p_equality_not_equals(p):
    '''equality : value NE value'''
    p[0] = {'lhs': p[1], 'eval':'NE', 'rhs': p[3]}

def p_equality_greater(p):
    '''equality : value GT value'''
    p[0] = {'lhs': p[1], 'eval':'GT', 'rhs': p[3]}

def p_equality_less(p):
    '''equality : value LT value'''
    p[0] = {'lhs': p[1], 'eval':'LT', 'rhs': p[3]}

def p_equality_greater_equals(p):
    '''equality : value GE value'''
    p[0] = {'lhs': p[1], 'eval':'GE', 'rhs': p[3]}

def p_equality_less_equals(p):
    '''equality : value LE value'''
    p[0] = {'lhs': p[1], 'eval':'LE', 'rhs': p[3]}

def p_value_int(p):
    '''value : INT'''
    p[0] = ('INT', int(p[1]))

def p_value_str(p):
    '''value : STRING'''
    p[0] = ('STR', str(p[1])[1:-1])

def p_value_id(p):
    '''value : ID'''
    p[0] = ('ID', str(p[1]))

def p_error(p):
    if not p:
        print("SYNTAX ERROR AT EOF")

sparser = yacc.yacc()

def parse(data, debug=0):
    sparser.error = 0
    p = sparser.parse(data, debug=debug)
    if sparser.error:
        return None
    return p
