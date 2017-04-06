defmodule Components.Assignment do
  def eval(%{line: line_number, type: :assignment, value: %{assignment: :definition, name: name, value: value, type: type}}, scope) do
    case Map.get(scope, name) do
      nil   -> {:ok, :new, Map.put(scope, name, %{type: type, value: eval_assign_variable(value)})}
      _else -> {:error, 1, name, line_number}
    end
  end

  def eval(%{line: line_number, type: :assignment, value: %{assignment: assignment, name: name, value: value}}, scope) do
    case Map.get(scope, name) do
      nil       -> {:error, 2, name, line_number}
      old_value ->
        case eval_variable(old_value, assignment, value, scope, line_number) do
          {:error, code, ops, line} -> {:error, code, name, line}
          type           -> {:ok, :redef, Map.put(scope, name, type)}
        end
    end
  end

  defp eval_variable(%{type: :int, value: current_value}, :"+=", value, _scope, _line_number) when is_integer(value), do: %{type: :int, value: current_value + value}
  defp eval_variable(%{type: :int, value: current_value}, :"-=", value, _scope, _line_number) when is_integer(value), do: %{type: :int, value: current_value - value}
  defp eval_variable(%{type: :int, value: current_value}, :"*=", value, _scope, _line_number) when is_integer(value), do: %{type: :int, value: current_value * value}
  defp eval_variable(%{type: :int, value: current_value}, :"/=", 0, _scope, line_number), do: {:error, 3, current_value, line_number}
  defp eval_variable(%{type: :int, value: current_value}, :"/=", value, _scope, _line_number) when is_integer(value), do: %{type: :int, value: current_value / value}
  defp eval_variable(nil, :=, value, _scope, _line_number) when is_integer(value), do:  %{type: :int, value: value}
  defp eval_variable(nil, :=, value, _scope, _line_number) when is_boolean(value), do:  %{type: :bool, value: value}
  defp eval_variable(nil, _operator, value, _scope, line_number), do: {:error, 4, value, line_number}
  defp eval_variable(_old, _operator, new, _scope, line_number), do: {:error, 5, new, line_number}

  defp eval_assign_variable(%{line: _line, type: :static_value, value: %{type: :number, value: value}}), do: value
  defp eval_assign_variable(%{line: _line, type: :static_value, value: value}), do: value
  defp eval_assign_variable(value), do: value
end
