defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string, [" ", "-"])
    |> Enum.map(fn s ->
      match = Regex.run(~r/[a-zA-Z]/, s)
      if match != nil, do: Enum.join(match) |> String.at(0), else: ""
    end)
    |> Enum.join()
    |> String.upcase()
  end
end
