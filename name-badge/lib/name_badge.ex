defmodule NameBadge do
  def print(id, name, department) do
    strings = []
    strings = if (id != nil), do: ["[#{id}]" | strings], else: strings
    strings = if (name != nil), do: [name | strings]
    strings = if (department != nil), do: [department |> String.upcase() | strings], else: ["OWNER" | strings]
    strings |> Enum.reverse() |> Enum.join(" - ")
  end
end
