defmodule Anagram do
  def match(base, candidates) do
    candidates
    |> Enum.filter(fn candidate -> String.downcase(base) != String.downcase(candidate) end)
    |> Enum.uniq_by(&String.downcase/1)
    |> Enum.filter(fn candidate -> check_letter_match(base, candidate) end)
  end

  defp check_letter_match(base, candidate) do
    sorted_base = String.downcase(base) |> String.codepoints() |> Enum.sort()
    sorted_candidate = String.downcase(candidate) |> String.codepoints() |> Enum.sort()
    Enum.join(sorted_base) == Enum.join(sorted_candidate)
  end
end
