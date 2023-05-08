defmodule TopSecret do
  
  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part({fdef, _line, [{:when, _, [{fname, _, args}, _]}, _]} = ast, acc) when fdef in [:def, :defp], do: append_to_acc(ast, acc, fname, args)
  def decode_secret_message_part({a, _b, [{fname, _, args}, _]} = ast, acc) when a in [:def, :defp], do: append_to_acc(ast, acc, fname, args)
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp append_to_acc(ast,acc,fname,args), do: if args != nil, do: {ast, [to_string(fname) |> String.slice(0, length(args)) | acc]}, else: {ast, ["" | acc]}

  def decode_secret_message(string) do
    {_, acc} = Macro.prewalk(to_ast(string), [], &decode_secret_message_part/2)
    acc |> Enum.reverse() |> Enum.join()
  end

end
