defmodule Components.Class do
  use GenServer
  require Logger

  @doc """
  Starts the class process to hold the class's state
  """
  def start_link(name, params, block) do
    GenServer.start_link(__MODULE__, {params, block}, name: name)
  end

  @doc """
  Initializes the gen server
  """
  def init({params, block}) do
    scope = %{variables: %{}, methods: %{}}
    IO.inspect block
    case index_block(block, scope) do
      {:error, code, ops, line} -> {:error, code, ops, line}
      definitions    ->
        IO.puts "Defined class with: #{inspect definitions}"
        {:ok, definitions}
    end
  end




  defp index_block([], scope), do: scope
  defp index_block(:empty, scope), do: scope
  defp index_block([%{line: line_number, type: :global_assignment, value: value}|rest], scope) do
    case Components.Assignment.eval(value, Map.get(scope, :variables)) do
      {:error, code, ops, line}         -> {:error, code, ops, line}
      {:ok, :new, variables} -> index_block(rest, Map.put(scope, :variables, variables))
      {:ok, :redef, _}       -> {:error, 1, value.name, line_number}
      _else                  -> {:error, 100, value.name, line_number}
    end
  end

  defp index_block([%{line: line_number, type: :definition, value: value}|rest], scope) do
    case Components.Assignment.eval(value, Map.get(scope, :variables)) do
      {:error, code, ops, line}         -> {:error, code, ops, line}
      {:ok, :new, variables} -> index_block(rest, Map.put(scope, :variables, variables))
      {:ok, :redef, _}       -> {:error, 1, value.name, line_number}
      _else                  -> {:error, 100, value.name, line_number}
    end
  end

  defp index_block(block, scope) when is_map(block) do
    index_block([block], scope)
  end
end
