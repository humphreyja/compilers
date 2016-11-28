import re

class SQLInterpreter:
    def __init__(self, prog, tables):
        self.prog = prog
        self.tables = tables

    def run(self):
        if self.prog['type'] == 'SELECT':
            fields = self.prog['fields']
            table = self.prog['table']
            where = self.prog['where']
            order = self.prog['order']
            limit = self.prog['limit']
            if table in self.tables:
                self.return_results(self.tables[table], fields, where, order, limit)
            else:
                print 'ERROR: Table ' + table + ' not found'

    def return_results(self, table, fields, where, order, limit):
        data_rows = []
        columns = []
        functions = []
        for field in fields:
            if field[0] == 'COLUMN':
                if field[1] in table:
                    # add the field to the column list
                    columns.append((field[1], field[2]))
                else:
                    raise BaseException("Field not in Table")
            elif field[0] == '*WILD*':
                # Adds all fields to the columns list
                for t_col in table:
                    columns.append((t_col, t_col))
            elif field[0] == '*COUNT*':
                columns.append(('*COUNT*', field[1]))
        accum = {}
        for row in table['id']:
            row_data = {}
            for o_column in table:
                row_data['*' + o_column + '*'] = table[o_column][row]
            valid_row = True
            for cond in where:
                ret = self.eval_cond(cond['equality']['lhs'], cond['equality']['rhs'], table, row, cond['equality']['eval'])
                log = cond['logical']

                if valid_row:
                    if log == 'AND' and ret == False:
                        valid_row = False
                        continue
                else:
                    if log == 'OR' and ret == True:
                        valid_row = True
                        continue

            if valid_row:
                for column in columns:
                    if column[0] == '*COUNT*':
                        print column
                        if not accum.has_key('count'):
                            accum['count'] = 0
                            accum['count_label'] = column[1]
                        accum['count'] += 1
                        continue
                    value = table[column[0]][row]
                    label = column[1]
                    row_data[label] = str(value)
                data_rows.append(row_data)

        data_rows.sort(key=lambda x: str(x['*' + order['id'] + '*']).lower(), reverse=order['asc'])

        if accum.has_key('count'):
            data_rows = [{accum['count_label']: accum['count']}]

        if limit == -1:
            limit = len(data_rows)

        print
        print 'Found ' + str(limit) + ' records'
        print '================================================================='
        for data in data_rows[:limit]:
            print_rows = []
            for d_column in data:
                if re.match(r'(?i)\*[a-zA-Z0-9_-]+\*', d_column):
                    continue
                print_rows.append(d_column + ': ' + str(data[d_column]))

            print ', '.join(print_rows)
        print

    def eval_cond(self, lhs, rhs, table, row, compare):
        lhs_v = lhs[1]
        rhs_v = rhs[1]
        if lhs[0] == 'ID':
            if lhs[1] in table:
                lhs_v = table[lhs[1]][row]
            else:
                raise BaseException("Field(" + lhs[1] + ") not in Table")

        if rhs[0] == 'ID':
            if rhs[1] in table:
                rhs_v = table[rhs[1]][row]
            else:
                raise BaseException("Field(" + rhs[1] + ") not in Table")

        print lhs_v
        print rhs_v

        if compare == 'EQ':
            return lhs_v == rhs_v
        if compare == 'NE':
            return lhs_v != rhs_v
        if compare == 'GT':
            return lhs_v > rhs_v
        if compare == 'LT':
            return lhs_v < rhs_v
        if compare == 'GE':
            return lhs_v >= rhs_v
        if compare == 'LE':
            return lhs_v <= rhs_v

    # Insert statements
    def add_statement(self, prog):
        self.prog = prog
