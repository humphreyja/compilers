defmodule ExTokens do

  #'ABSF' 'XABSF' 'INTF' 'XINTF' 'MODF' 'XMODF' 'MAX0F' 'MAX1F' 'XMAX0F' 'XMAX1F' 'MIN0F' 'MIN1F' 'XMIN0F' 'XMIN1F'
  def get_tokens(block) do
     :tokens.string(String.to_char_list(block))
  end

  def parse(block) do
    case :tokens.string(String.to_char_list(block)) do
      {:ok, tokens, _} -> :syntax.parse(tokens)
      {:error, {_, _, {:illegal, char}}, _} -> {:error, "Illegal character: #{char}"}
    end
  end
end
