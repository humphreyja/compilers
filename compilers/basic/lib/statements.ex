defmodule Statements do
  use GenServer

  @name Server.Statements.Custom

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def add(%{number: number, statement: value}) do
    GenServer.cast(@name, {:add, %{number: number, statement: value}})
    "#{number}"
  end

  def handle_cast({:add, %{number: number, statement: value}}, state) do
    {:noreply, Map.merge(state, %{"#{number}" => value})}
  end

  def resolve(number) do
    case GenServer.call(@name, {:get, number}) do
      {:ok, value} -> value
      _err -> raise "line #{number} is not initialized"
    end
  end

  def handle_call({:get, number}, _from, state) do
    {:reply, Map.fetch(state, "#{number}"), state}
  end
end
