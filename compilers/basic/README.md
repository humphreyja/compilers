To run, install elixir (`brew install elixir`).
Then run `./basic` to start the pre-compiled version
If you wish to compile your own version, build it with `mix escript.build`

By default, it will use `code.basic` as the source code, you may pass in a file
as an argument if you want to run a different file.  See the provided screenshot
to see a sample run.

## Syntax
It is in BASIC syntax though is very minimal and works more like an interpreter/translator to Elixir.

### Printing

```
1 PRINT "A simple message"
2 LET n$ = 10
3 PRINT "A complex message: "; n$
4 PRINT "Even more "; n$; " complex"
```

### Input

```
1 LET n$ = 10
2 PRINT "N = "; n$
3 INPUT "Enter a new number: "; n$
4 PRINT "Now N = "; n$
```

### If statement

This example will not print out anything
```
1 LET n$ = 10
10 IF n$ = 10 THEN 99
20 PRINT "The Number is: "; n$
99 END
```

### GOTO

This shows a simple loop made with the GOTO statement, the user must type `1` in order to exit the loop
```
1 LET n$ = 10
10 IF n$ = 1 THEN 41
20 PRINT "The Number is: "; n$
30 INPUT "Enter a new number: "; n$
40 GOTO 10
41 END
```

### For Loop

This will print out `Out: 1 of 1`, `Out: 2 of 1`, etc until `Out: 5 of 2` before printing out `The End`. This shows Nesting loops working.
```
1 FOR j$ = 1 TO 2
2 FOR k$ = 1 TO 5
3 PRINT "Out: "; k$; " of "; j$
4 NEXT
5 NEXT
6 PRINT "The End"
```
