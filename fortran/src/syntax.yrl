Nonterminals
  grammar lines line numbered_statement statement jump space
  .

Terminals
  '(' ')' ',' int float

  'DIMENSION' 'EQUIVALENCE' 'IF' 'GO TO' 'STATEMENT'
  'ASSIGN' 'TO' 'DO' 'FORMAT' 'READ' 'READ INPUT TAPE' 'WRITE' 'WRITE OUTPUT TAPE' 'PRINT' 'PUNCH' 'READ TAPE'
  'READ DRUM' 'WRITE TAPE' 'WRITE DRUM' 'END FILE' 'REWIND' 'BACKSPACE' 'PAUSE' 'STOP' 'CONTINUE' 'FREQUENCY'

  '=' '+' '-' '*' '/'

  identifier newline
  .


Rootsymbol grammar.

grammar -> lines : '$1'.

space -> newline.
space -> newline space.

lines -> line : '$1'.
lines -> line space : '$1'.
lines -> space lines : '$2'.
lines -> line lines : ['$1'|'$2'].

line -> numbered_statement : '$1'.
line -> statement : #{type => 'statement', statement => '$1'}.

numbered_statement -> 'STATEMENT' statement : #{type => 'statement', number => extract_token('$1'), statement => '$2'}.
statement -> jump : '$1'.
statement -> 'DIMENSION' variable : #{type => 'dimension', value => '$2'}.
statement -> 'READ' format_args : #{type => 'read', value => '$2'}.
statement -> 'WRITE' format_args : #{type => 'write', value => '$2'}.
statement -> 'PRINT' format_args : #{type => 'print', value => '$2'}.

format_args -> int ',' list : #{format_statement => '$1', list => '$3'}.

jump -> 'GO TO' int : #{type => 'jump', value => extract_token('$2')}.

Erlang code.
  extract_token({_Token, _Line, Value}) -> Value.
