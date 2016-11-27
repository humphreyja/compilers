defmodule Statements.Input do
  def eval(value) do
    i_var = IO.gets resolve(value.message)
    Identifiers.update(value.variable, i_var)
  end

  defp resolve(value) do
    String.replace("#{value}", "\"", "")
  end
end
