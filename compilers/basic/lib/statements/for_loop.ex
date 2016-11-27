defmodule Statements.ForLoop do
  use GenServer

  @name Server.ForLoop.Stack

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  def eval(value, line) do
    GenServer.call(@name, {:create, value, line})
  end

  def init(:ok) do
    {:ok, []}
  end

  def next do
    GenServer.call(@name, :next)
  end

  def handle_call({:create, value, line}, _, state) do
    Identifiers.add(%{name: value.index, value: value.initial})
    {:reply, :ok, [%{line: resolve(line), index: value.index, max: resolve(value.max)}] ++ state}
  end

  def handle_call(:next, _from, []), do: get_next([])
  def handle_call(:next, _from, state) do
    get_next(state)
  end

  defp get_next([]), do: {:reply, nil, []}
  defp get_next(state) do
    loop = List.first(state)
    current_val = Identifiers.resolve(loop.index)
    if current_val < loop.max do
      Identifiers.update(loop.index, current_val + 1)
      {:reply, {:jump_past, loop.line}, state}
    else
      get_next(List.delete_at(state, 0))
    end
  end

  defp resolve(%{type: :identifier, value: value}) do
    Identifiers.resolve(value)
  end

  defp resolve(%{type: :int, value: value}) do
    case Integer.parse("#{value}") do
      {num, _rem} -> num
      :error -> raise "invalid value for type Int: #{inspect value}"
    end
  end

  defp resolve(value) do
    String.replace("#{value}", "\"", "")
    |> String.replace("\n", "")
  end
end
