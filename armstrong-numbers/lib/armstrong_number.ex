defmodule ArmstrongNumber do
  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    digits |> Enum.map(fn x -> Integer.pow(x, length(digits)) end) |> Enum.sum() == number
  end
end
