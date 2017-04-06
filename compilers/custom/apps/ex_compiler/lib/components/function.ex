defmodule Components.Function do
  use GenServer

  @doc """
  Starts the class process to hold the class's state
  """
  def start_link(%{name: name, block: block, params: params, return_type: ret_type}, scope) do
    GenServer.start_link(__MODULE__, {name, block, params, ret_type, scope}, [])
  end

  @doc """
  Initializes the gen server
  """
  def init({name, block, params, ret_type, class_scope}) do

  end
end
