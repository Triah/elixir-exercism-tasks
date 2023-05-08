defmodule LogParser do
  def valid_line?(line), do: line =~ ~r/^(\[(INFO|DEBUG|ERROR|WARNING)\])/

  def split_line(line), do: String.split(line, ~r/\<([\*|\~|\-|\=]*)\>/)

  def remove_artifacts(line), do: String.replace(line, ~r/end-of-line(\d+)/i, "")

  def tag_with_user_name(line) do
    match = Regex.run(~r/User\s*(\S+)/, line)
    if match != nil do
      "[USER] " <> Enum.at(match, 1) <> " " <> line
    else
      line
    end
  end
end
