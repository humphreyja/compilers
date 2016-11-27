defmodule Statements.Cond do
  def eval(%{lhs: lhs, rhs: rhs, goto: _}) do
    resolve(lhs) == resolve(rhs)
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
