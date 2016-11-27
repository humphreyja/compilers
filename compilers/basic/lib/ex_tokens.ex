defmodule ExTokens do

  def main(args) do
    {_options, other_text, _invalid_args} = OptionParser.parse args

    case other_text do
      [] -> IO.puts "Please provide the file to load, loading default test file (code.basic)."
            code_file = Path.join(~w(#{File.cwd!} code.basic))
            test(code_file)
      _  -> test other_text
    end
  end

  def get_tokens(block) do
     :tokens.string(String.to_char_list(block))
  end

  def ast(block) do
    case :tokens.string(String.to_char_list(block)) do
      {:ok, tokens, _} -> :syntax.parse(tokens)
      {:error, {_, _, {:illegal, char}}, _} -> {:error, "Illegal character: #{char}"}
    end
  end

  def test(file_path) do


    case File.read(file_path) do
      {:ok, contents} -> parse contents
      _               -> IO.puts "Failed to read from file"
    end
  end

  def parse(block) do
    # case :tokens.string(String.to_char_list(block)) do
    #   {:ok, tokens, _} -> :syntax.parse(tokens)
    #   {:error, {_, _, {:illegal, char}}, _} -> {:error, "Illegal character: #{char}"}
    # end

    with {:ok, tokens, _} <- :tokens.string(String.to_char_list(block)),
         {:ok, ast} <- :syntax.parse(tokens),
    do: cat_and_eval(ast)
  end

  defp cat_and_eval(ast) do

    lines = cat_lines(ast)
    Interpreter.set_lines(lines)
    eval_lines(lines)
  end

  defp cat_lines(%{type: :statement, value: value}), do: [Statements.add(value)]
  defp cat_lines([%{type: :statement, value: value} | statements]) do
    [Statements.add(value)] ++ cat_lines(statements)
  end

  defp eval_lines([]), do: :done
  defp eval_lines([line | lines]) do
    case eval(Statements.resolve(line), line) do
      {:jump, number} -> eval_lines(Interpreter.lines(number))
      {:jump_past, number} -> eval_lines(Interpreter.lines_past(number))
      :done -> :done
      _else -> eval_lines(lines)
    end
  end

  defp eval(%{type: :print, value: value}, _), do: Statements.Print.eval(value)

  defp eval(%{type: :assign, value: value}, _), do: Identifiers.add(value)

  defp eval(%{type: :input, value: value}, _), do: Statements.Input.eval(value)

  defp eval(%{type: :cond, value: value}, _) do
    if Statements.Cond.eval(value) do
      {:jump, value.goto}
    end
  end

  defp eval(%{type: :end, value: value}, _), do: Statements.End.eval
  defp eval(%{type: :goto, value: value}, _), do: {:jump, value}
  defp eval(%{type: :for_loop, value: value}, line) do
    Statements.ForLoop.eval(value, line)
  end

  defp eval(%{type: :next, value: value}, _), do: Statements.ForLoop.next

  defp eval(%{type: type, value: value}, _), do: IO.puts "Found unknown: type: #{inspect type}, value: #{inspect value}"
end
