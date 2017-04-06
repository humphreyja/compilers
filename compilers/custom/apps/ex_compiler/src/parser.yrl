Nonterminals
  grammar modules module parameters block identifiers
  mod_block definitions definition obj_type statements statement
  condition loop call terminal space all_conditional_operator
  conditional conditional_operator arguments
  statics_or_names static_value assignment assignment_math
  operation math
  .

Terminals
  '(' ')' '{' '}' ',' number

  'if' 'else' 'break' 'while' 'return' 'continue' 'class'
  'and' 'or' 'int' 'bool' 'true' 'false' 'void'

  '==' '<=' '>=' '<' '>' '!=' '!' '=' '+' '+=' '-' '-=' '*' '*='
  '/' '/=' '%' newline '.'

  identifier
  .


Rootsymbol grammar.

grammar -> modules : '$1'.

space -> newline.
space -> newline space.

modules -> module : '$1'.
modules -> module space : '$1'.
modules -> space modules : '$2'.
modules -> module modules : ['$1'|'$2'].

module -> 'class' identifier parameters mod_block : #{line => extract_line('$2'), type => 'class', value => #{name => extract_token('$2'), params => '$3', block => '$4'}}.

parameters -> '(' ')' : [].
parameters -> '(' identifiers ')' : '$2'.

identifiers -> identifier : '$1'.
identifiers -> identifier ',' identifiers : ['$1'|'$3'].

mod_block -> '{' '}' : 'empty'.
mod_block -> '{' space '}' : 'empty'.
mod_block -> '{' definitions '}' : '$2'.

definitions -> definition : '$1'.
definitions -> definition space : '$1'.
definitions -> space definitions : '$2'.
definitions -> definition definitions : ['$1'|'$2'].

definition -> obj_type identifier parameters block : #{line => extract_line('$2'), type => 'definition', value => #{name => extract_token('$2'), return_type => '$1', params => '$3', block => '$4'}}.
definition -> assignment : #{line => 'nil', type => 'global_assignment', value => '$1'}.


obj_type -> 'bool' : 'bool'.
obj_type -> 'int' : 'int'.
obj_type -> 'void' : 'void'.


block -> '{' '}' : 'empty'.
block -> '{' space '}' : 'empty'.
block -> '{' statements '}' : '$2'.

statements -> statement : '$1'.
statements -> statement space : '$1'.
statements -> space statements : '$2'.
statements -> statement statements : ['$1'|'$2'].

statement -> condition :  '$1'.
statement -> loop :  '$1'.
statement -> assignment :  '$1'.
statement -> call :  '$1'.
statement -> terminal :  '$1'.

terminal -> 'return' : #{line => extract_line('$1'), type => 'terminal', value => #{type => 'return', value => 'nil'}}.
terminal -> 'return' static_value : #{line => extract_line('$1'), type => 'terminal', value => #{type => 'return', value => '$2'}}.
terminal -> 'return' identifier : #{line => extract_line('$1'), type => 'terminal', value => #{type => 'return', value => '$2'}}.
terminal -> 'break' : #{line => extract_line('$1'), type => 'terminal', value => #{type => 'break'}}.
terminal -> 'continue' : #{line => extract_line('$1'), type => 'terminal', value => #{type => 'continue'}}.

loop -> 'while' '(' conditional ')' block : #{line => extract_min_line('$1'), type => 'loop', value => #{style => 'while', condition => '$3', block => '$5'}}.

condition -> 'if' '(' conditional ')' block : #{line => extract_min_line('$1'), type => 'condition', value => #{condition => '$3', if_true => '$5', if_false => 'nil'}}.
condition -> 'if' '(' conditional ')' block 'else' block : #{line => extract_min_line('$1'), type => 'condition', value => #{condition => '$3', if_true => '$5', if_false => '$7'}}.

conditional -> '!' conditional : #{line => extract_min_line('$1'), type => 'conditional', value => #{lhs => '$2', condition => 'not', rhs => 'nil'}}.
conditional -> '(' conditional ')' : #{line => extract_min_line('$1'), type => 'conditional', value => #{lhs => #{type => 'group', value => '$2'}, rhs => 'nil', condition => 'nil'}}.
conditional -> '(' conditional ')' all_conditional_operator conditional : #{line => extract_min_line('$1'), type => 'conditional', value => #{lhs => #{type => 'group', value => '$2'}, rhs => '$5', condition => '$4'}}.
conditional -> 'true' : 'true'.
conditional -> 'false' : 'false'.
conditional -> 'true' all_conditional_operator conditional : #{line => extract_min_line('$1'), type => 'conditional', value => #{lhs => 'true', rhs => '$3', condition => '$2'}}.
conditional -> 'false' all_conditional_operator conditional : #{line => extract_min_line('$1'), type => 'conditional', value => #{lhs => 'false', rhs => '$3', condition => '$2'}}.
conditional -> call : '$1'.
conditional -> call all_conditional_operator conditional : #{line => 'nil', type => 'conditional', value => #{lhs => '$1', rhs => '$3', condition => '$2'}}.
conditional -> number : extract_token('$1').
conditional -> number conditional_operator conditional : #{line => 'nil', type => 'conditional', value => #{lhs => extract_token('$1'), rhs => '$3', condition => '$2'}}.



conditional_operator -> '==' : '=='.
conditional_operator -> '!=' : '!='.
conditional_operator -> '>=' : '>='.
conditional_operator -> '>' : '>'.
conditional_operator -> '<=' : '<='.
conditional_operator -> '<' : '<'.
all_conditional_operator -> 'and' : 'and'.
all_conditional_operator -> 'or' : 'or'.
all_conditional_operator -> conditional_operator : '$1'.

call -> identifier : '$1'.
call -> identifier '.' identifier arguments : #{line => extract_line('$1'), type => 'call', value => #{module => '$1', function => '$3', args => '$4'}}.
call -> identifier arguments : #{line => extract_line('$1'), type => 'call', value => #{function => '$1', args => '$2'}}.

arguments -> '(' ')' : [].
arguments -> '(' statics_or_names ')' : '$2'.

statics_or_names -> static_value : '$1'.
statics_or_names -> static_value ',' statics_or_names : ['$1'|'$3'].
statics_or_names -> identifier : '$1'.
statics_or_names -> identifier ',' statics_or_names : ['$1'|'$3'].

assignment -> obj_type identifier : #{line => extract_line('$2'), type => 'assignment', value => #{name => extract_token('$2'), type => '$1', value => 'nil', assignment => 'definition'}}.
assignment -> obj_type identifier '=' static_value : #{line => extract_line('$2'), type => 'assignment', value => #{name => extract_token('$2'), type => '$1', value => '$4',  assignment => 'definition'}}.

assignment -> identifier '=' identifier : #{line => extract_line('$1'), type => 'assignment', value => #{name => extract_token('$1'), value => #{type => variable, value => extract_token('$3')},  assignment => '='}}.
assignment -> identifier '=' operation : #{line => extract_line('$1'), type => 'assignment', value => #{name => extract_token('$1'), value => '$3',  assignment => '='}}.
assignment -> identifier assignment_math operation : #{line => extract_line('$1'), type => 'assignment', value => #{name => extract_token('$1'), value => '$3', assignment => '$2'}}.

assignment_math -> '+=' : '+='.
assignment_math -> '-=' : '-='.
assignment_math -> '*=' : '*='.
assignment_math -> '/=' : '/='.

static_value -> 'true' : #{line => extract_line('$1'), type => 'static_value', value => #{type => 'boolean', value => 'true'}}.
static_value -> 'false' : #{line => extract_line('$1'), type => 'static_value', value => #{type => 'boolean', value => 'false'}}.
static_value -> number : #{line => extract_line('$1'), type => 'static_value', value => #{type => 'number', value => list_to_integer(extract_token('$1'))}}.

operation -> number : list_to_integer(extract_token('$1')).
operation -> '(' operation ')' : #{line => extract_min_line('$1'), type => 'operation', value => #{lhs => #{type => 'group', value => '$2'}, operation => 'nil', rhs => 'nil'}}.
operation -> '(' operation ')' math operation : #{line => extract_min_line('$1'), type => 'operation', value => #{lhs => #{type => 'group', value => '$2'}, operation => '$4', rhs => '$5'}}.
operation -> number math operation : #{line => extract_line('$1'), type => 'operation', value => #{lhs => list_to_integer(extract_token('$1')), rhs => '$3', operator => '$2'}}.

math -> '+' : '+'.
math -> '-' : '-'.
math -> '*' : '*'.
math -> '/' : '/'.
math -> '%' : '%'.

Erlang code.
  extract_token({_Token, _Line, Value}) -> Value.
  extract_line({_Token, Line, _Value}) -> Line.
  extract_min_line({_Token, Line}) -> Line.
