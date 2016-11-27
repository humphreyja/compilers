Nonterminals
  grammar lines line statement space f_value value
  .

Terminals
  '(' ')' ',' ';' int

  'IF'
  'ELSE'
  'THEN'
  'FOR'
  'TO'
  'NEXT'
  'WHILE'
  'WEND'
  'REPEAT'
  'UNTIL'
  'DO'
  'LOOP'
  'GOTO'
  'GOSUB'
  'ON'
  'DEF'
  'INPUT'
  'PRINT'
  'LET'
  'END'

  '=' '+' '-' '*' '/'

  identifier newline string
  .


Rootsymbol grammar.

grammar -> lines : '$1'.

space -> newline.
space -> newline space.

lines -> line : '$1'.
lines -> line space : '$1'.
lines -> space lines : '$2'.
lines -> line lines : ['$1'|'$2'].

line -> int statement : #{type => 'statement', value => #{statement => '$2', number => extract_token('$1')}}.

statement -> 'LET' identifier '=' value : #{type => 'assign', value => #{name => extract_token('$2'), value => '$4'}}.
statement -> 'PRINT' : #{type => 'print', value => ''}.
statement -> 'PRINT' f_value : #{type => 'print', value => '$2'}.
statement -> 'INPUT' string ';' identifier : #{type => 'input', value => #{message => extract_token('$2'), variable => extract_token('$4')}}.
statement -> 'IF' value '=' value 'THEN' int : #{type => 'cond', value => #{lhs => '$2', rhs => '$4', goto => extract_token('$6')}}.
statement -> 'END' : #{type => 'end', value => ''}.
statement -> 'GOTO' int : #{type => 'goto', value => extract_token('$2')}.
statement -> 'FOR' identifier '=' value 'TO' value : #{type => 'for_loop', value => #{index => extract_token('$2'), initial => '$4', max => '$6'}}.
statement -> 'NEXT' : #{type => 'next', value => ''}.

f_value -> string : #{first => extract_token('$1')}.
f_value -> value : #{first => '$1'}.
f_value -> string ';' f_value : #{first => extract_token('$1'), rest => '$3'}.
f_value -> value ';' f_value : #{first => '$1', rest => '$3'}.

value -> int : #{type => 'int', value => extract_token('$1')}.
value -> identifier : #{type => 'identifier', value => extract_token('$1')}.

Erlang code.
  extract_token({_Token, _Line, Value}) -> Value.
