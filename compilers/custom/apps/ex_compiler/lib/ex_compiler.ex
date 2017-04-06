defmodule ExCompiler do
  use GenServer
  require Logger

  @doc """
  Starts the process to match parentheses
  """
  def start_link, do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)

  @doc """
  Initializes the gen server
  """
  def init(:ok), do: {:ok, %{}}

  @doc """
  Return :ok for an empty code block

  # Example
  iex> ExCompiler.compile("")
  :ok

  """
  def compile(""), do: :ok

  @doc """
  Call the server to process the block

  # Example
  iex> ExCompiler.compile(" ")
  :ok

  """
  def compile(grammer), do: GenServer.call(__MODULE__, {:parse, String.to_char_list(grammer)})

  @doc """
  Parses the block
  """
  def handle_call({:parse, grammer}, _from, state) do
    case :lexer.string(grammer) do
      {:ok, tokens, _} -> {:reply, start_compiling(tokens), state}
      {:error, {_, _, {:illegal, char}}, _} -> {:reply, {:error, "Illegal character: #{char}"}, state}
    end
  end

  defp start_compiling(tokens) do
    case :parser.parse(tokens) do
      {:ok, ast} ->
        eval_ast(ast)
      {:error, {_, _, message}} -> {:error, Enum.join(message, "")}
    end
  end

  defp eval_ast([]), do: :ok
  defp eval_ast([ast | rest]) do
    case index_class(ast) do
      {:error, code} -> {:error, code}
      _else -> eval_ast(rest)
    end
  end

  defp eval_ast(ast) do
     index_class(ast)
  end

  defp index_class(%{line: line_number, type: :class, value: %{name: name, params: params, block: block}}) do
    class_name = String.to_atom("Class::#{name}")
    case GenServer.whereis(class_name) do
      nil ->  case Supervisors.Class.start_class(class_name, params, block) do
        {:error, code, ops, line} when is_integer(code) -> {:error, code, ops, line}
        {:error, {:bad_return_value, {:error, code, ops, line}}} -> {:error, code, ops, line}
        {:error, other} -> {:error, 100, other, line_number}
        _else -> :ok
      end
      _err -> {:error, 6, class_name, line_number}
    end
  end
end
