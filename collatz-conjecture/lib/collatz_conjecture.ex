defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()

  def calc(input) when is_integer(input) and input > 0 do
    if rem(input, 2) == 0, do: calculate_even(input, 0), else: calculate_odd(input, 0)
  end

  defp calculate_even(number, steps) do
    next_number = number / 2

    if rem(round(next_number), 2) == 0,
      do: calculate_even(round(next_number), steps + 1),
      else: calculate_odd(round(next_number), steps + 1)
  end

  defp calculate_odd(1, steps), do: steps

  defp calculate_odd(number, steps) do
    next_number = number * 3 + 1

    if rem(round(next_number), 2) == 0,
      do: calculate_even(round(next_number), steps + 1),
      else: calculate_odd(round(next_number), steps + 1)
  end
end
