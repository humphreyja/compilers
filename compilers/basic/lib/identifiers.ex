defmodule Identifiers do
  use GenServer

  @name Server.Identifiers.Custom

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def add(%{name: name, value: value}) do
    GenServer.cast(@name, {:add, %{name: name, value: resolve_type(value)}})
  end

  def handle_cast({:add, %{name: name, value: value}}, state) do
    {:noreply, Map.merge(state, %{"#{name}" => value})}
  end

  def resolve(name) do
    case GenServer.call(@name, {:get, name}) do
      {:ok, value} -> value
      _err -> raise "#{name} is not initialized"
    end
  end

  def handle_call({:get, name}, _from, state) do
    {:reply, Map.fetch(state, "#{name}"), state}
  end

  def update(name, value) do
    GenServer.cast(@name, {:add, %{name: name, value: resolve_type(%{type: :int, value: value})}})
  end

  def delete(name) do
    GenServer.cast(@name, {:delete, name})
  end

  def handle_cast({:delete, name}, state) do
    {:noreply, Map.delete(state, "#{name}")}
  end

  defp resolve_type(%{type: :int, value: value}) do
    case Integer.parse("#{value}") do
      {num, _rem} -> num
      :error -> raise "invalid value for type Int: #{inspect value}"
    end
  end

end
