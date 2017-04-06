defmodule ExTokens do
  def get_tokens(block) do
     :lexer.string(String.to_char_list(block))
  end

  def parse(block) do
    case :lexer.string(String.to_char_list(block)) do
      {:ok, tokens, _} -> :parser.parse(tokens)
      {:error, {_, _, {:illegal, char}}, _} -> {:error, "Illegal character: #{char}"}
    end
  end
end
