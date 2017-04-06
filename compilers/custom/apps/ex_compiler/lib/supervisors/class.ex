defmodule Supervisors.Class do
  use Supervisor

  @name Class.Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def init(:ok) do
    children = [
      worker(Components.Class, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

  def start_class(class_name, params, block) do
    Supervisor.start_child(@name, [class_name, params, block])
  end
end
