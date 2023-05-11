defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(1), do: [2]
  def generate(2), do: [2, 1]
  def generate(count), do: generate(count, [1, 2])

  defp generate(count, curr_list) when is_integer(count) and count > 2 do
    [head | [second | _tail]] = curr_list
    next_list = [generate_next(head, second) | curr_list]

    case count do
      3 -> Enum.reverse(next_list)
      _ -> generate(count - 1, next_list)
    end
  end

  defp generate(_count, _curr_list),
    do: raise(ArgumentError, message: "count must be specified as an integer >= 1")

  defp generate_next(first, second) when is_integer(first) and is_integer(second),
    do: first + second
end
