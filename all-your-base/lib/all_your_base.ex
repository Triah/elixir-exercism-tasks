defmodule AllYourBase do
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    trimmed_list = remove_leading_zero(digits)

    cond do
      output_base < 2 -> {:error, "output base must be >= 2"}
      input_base < 2 -> {:error, "input base must be >= 2"}
      Enum.any?(trimmed_list, fn x -> x < 0 or x >= input_base end) ->
        {:error, "all digits must be >= 0 and < input base"}
      length(trimmed_list) == 0 -> {:ok, [0]}
        true -> handle_valid_digits(trimmed_list, input_base, output_base)
    end
  end

  defp handle_valid_digits(trimmed_list, input_base, output_base) do
    as_base_ten = convert_to_base_ten(trimmed_list, input_base)
    convert_digit_to_output(floor(as_base_ten), output_base)
  end

  defp convert_to_base_ten(trimmed_list, input_base), do: convert_num_to_base_ten(trimmed_list, input_base, length(trimmed_list) -1)  

  defp convert_num_to_base_ten(trimmed_list, input_base, power, total \\ 0)
  defp convert_num_to_base_ten([head | _tail], input_base, 0, total), do: (head * :math.pow(input_base, 0)) + total
  defp convert_num_to_base_ten([head | tail], input_base, power, total) do
    
    current_value = head * :math.pow(input_base, power)
    convert_num_to_base_ten(tail, input_base, power - 1, total + current_value)
  end

  defp convert_digit_to_output([], _), do: {:ok, [0]}

  defp convert_digit_to_output(_current_total, output_base) when output_base < 2,
    do: {:error, "output base must be >= 2"}

  defp convert_digit_to_output(current_total, output_base, remainers \\ []) do
    current_quotient = floor(current_total / output_base)

    if current_quotient < 1,
      do: {:ok, [rem(current_total, output_base) | remainers]},
      else:
        convert_digit_to_output(current_quotient, output_base, [
          rem(current_total, output_base) | remainers
        ])
  end

  defp remove_leading_zero([0 | tail]), do: remove_leading_zero(tail)
  defp remove_leading_zero(list), do: list
end
