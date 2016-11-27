defmodule Interpreter do
  use GenServer

  @name Server.Interpreter.Custom

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  def init(:ok) do
    {:ok, []}
  end

  def lines do
    GenServer.call(@name, :lines)
  end

  def handle_call(:lines, _from, state) do
    {:reply, state, state}
  end

  def lines(number) do
    GenServer.call(@name, {:lines, number})
  end

  def lines_past(number) do
    GenServer.call(@name, {:lines_past, number})
  end

  def handle_call({:lines, number}, _from, state) do
    case Enum.find_index(state, fn (e) -> e == "#{number}" end) do
      nil -> {:reply, state, state}
      idx -> line_count = Enum.count state
             {:reply, Enum.take(state, idx - line_count), state}
    end
  end

  def handle_call({:lines_past, number}, _from, state) do
    case Enum.find_index(state, fn (e) -> e == "#{number}" end) do
      nil -> {:reply, state, state}
      idx -> line_count = Enum.count state
             {:reply, Enum.take(state, (idx + 1) - line_count), state}
    end
  end

  def set_lines(lines) do
    GenServer.cast(@name, {:set_lines, lines})
  end

  def handle_cast({:set_lines, lines}, _state) do
    {:noreply, lines}
  end

end
