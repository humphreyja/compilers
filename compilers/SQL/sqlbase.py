import sys

if sys.version_info[0] >= 3:
    raw_input = input

import sqllex
import sqlparse
import sqlinterp
import sqltable

# If a filename has been specified, we try to run it.
# If a runtime error occurs, we bail out and enter
# interactive mode below
if len(sys.argv) == 2:
    data = open(sys.argv[1]).read()
    prog = sqlparse.parse(data)
    if not prog:
        raise SystemExit
    s = sqlinterp.SQLInterpreter(prog, sqltable.tables)
else:
    s = sqlinterp.SQLInterpreter(('None'), sqltable.tables)

while 1:
    line = raw_input("[SQL] ").strip()
    if len(line) > 0:
        while line[-1] != ';':
            line += '\n' + raw_input("[SQL] ").strip()
        prog = sqlparse.parse(line)
        s.add_statement(prog)
        s.run()
