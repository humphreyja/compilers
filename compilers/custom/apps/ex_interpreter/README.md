# EXCP

Matches parentheses, brackets, and braces.  Discards everything else.  
Returns an error if a block mismatch is found.

### Running
You must have erlang(BEAM VM) installed.

run `excp` to start the program.  Type into the prompt.

### Running from IEX
Just load the file from the Elixir ex_interpreter.

```
iex parser.ex
```

Then to test the program.
```
iex> {:ok, parser} = Parser.start_link
iex> Parser.compile(parser, "(()){}")
```

### Compiling
You must have erlang(BEAM VM) installed. (Apparently you don't need Elixir to compile Elixir....cool).

run `mix escript.build` to build BEAM executable.
