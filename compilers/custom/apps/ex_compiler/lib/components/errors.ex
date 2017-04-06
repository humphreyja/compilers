defmodule Components.Errors do
  def error(code, ops, line) do
    "#{error_header(code, line)} #{do_error(code, ops)}"
  end

  defp do_error(1, name), do: "variable: #{name} is already defined."
  defp do_error(2, name), do: "#{name} is not defined."
  defp do_error(3, _ops), do: "cannot divide by 0."
  defp do_error(4, _ops), do: "operation against a nil object."
  defp do_error(5, _ops), do: "illegal assignment."
  defp do_error(6, name), do: "class: #{name} is already defined."
  defp do_error(7, name), do: "function: #{name} is already defined."
  defp do_error(code, ops), do: "An unknown error occured (Ops: #{inspect ops})"

  defp error_header(code, nil), do: "Error(#{code}):"
  defp error_header(code, line), do: "Error(#{code} on line: #{line}):"
end
