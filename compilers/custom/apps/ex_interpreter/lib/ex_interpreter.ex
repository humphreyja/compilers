defmodule ExInterpreter do
  require Logger
  require ExCompiler

  def main(args) do
    {_options, other_text, _invalid_args} = OptionParser.parse args

    case other_text do
      [] -> start_interpreter
      _  -> read_file other_text
    end
  end

  defp call_compiler(input) do
    case ExCompiler.compile input do
      {:error, message} -> Logger.error "Compilation error: #{inspect message}"
      :ok               -> Logger.debug "Compiled Successfully"
      {:error, code, ops, line} -> Logger.debug "#{inspect Components.Errors.error(code, ops, line)}"
    end
  end

  defp read_file(filename) do
    case File.read filename do
      {:ok, contents} -> call_compiler contents
      _               -> Logger.error "Failed to read from file"
    end
  end

  defp start_interpreter do
    IO.puts "'exit' to close program"
    get_input IO.gets("|>  ")
  end

  defp get_input("exit\n") do
  end

  defp get_input("\n") do
    get_input IO.gets("|>  ")
  end

  defp get_input(input) do
    call_compiler input
    :timer.sleep 50
    get_input IO.gets("|>  ")
  end
end
