To run, start with `python sqlbase.py` and it will open up the interpreter. To run a command, the last character needs to
be a semicolon.

## Adding a new table
Just simply add a new dictionary to the `sqltable.py` module with the same structure and add it to the `tables` variable in that
module.

## Syntax
This only handles reading from the tables (defined in `sqltable.py`).  It would require a lot more energy to complete
all the other statements.  It also does not handle JOINS and grouping. The keywords are case insensitive.

### Basic SELECT

```
SELECT * FROM students;
```

### Selecting a certain field

```
SELECT age FROM students;

SELECT age, first_name FROM students;
```


### Renaming a column

```
SELECT first_name AS name FROM students;
```

### Limiting

```
SELECT * FROM students LIMIT 1;
```

### Sorting

```
SELECT * FROM students ORDER BY first_name;
```

### Where conditions

```
SELECT * FROM students WHERE age >= 21;

SELECT * FROM students WHERE age >= 21 OR last_name = 'Humphrey';

SELECT * FROM students WHERE age < 22 AND last_name = 'Humphrey';
```

## Count

```
SELECT COUNT(*) FROM students;
```

### All Together Now

```
SELECT first_name as name FROM students WHERE last_name = 'Humphrey' OR age >= 21 ORDER BY last_name;

SELECT COUNT(*) as Total FROM students WHERE last_name = 'Humphrey' OR age >= 21 ORDER BY last_name;

SELECT age FROM students WHERE age >= 21 LIMIT 1;
```
