defmodule Statements.Print do
  def eval(message) do
    IO.puts compose(message)
  end

  defp compose(%{first: first, rest: rest}) do
    "#{resolve(first)}#{compose(rest)}"
  end

  defp compose(%{first: first}) do
    resolve(first)
  end

  defp resolve(%{type: :identifier, value: value}) do
    Identifiers.resolve(value)
  end

  defp resolve(value) do
    String.replace("#{value}", "\"", "")
    |> String.replace("\n", "")
  end
end
