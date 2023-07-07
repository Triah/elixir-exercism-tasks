defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise("There is not 0th prime")
  def nth(1), do: 2

  def nth(count) do
    find_prime(count, 2, 1)
  end

  defp find_prime(target, current_number, previous_primes) do
    cond do
      prime?(current_number) && target - 1 == previous_primes ->
        current_number

      prime?(current_number) ->
        find_prime(target, current_number + 1, previous_primes + 1)

      true ->
        find_prime(target, current_number + 1, previous_primes)
    end
  end

  defp prime?(current_number) do
    cond do
      rem(current_number, 2) == 0 -> false
      rem(current_number, 3) == 0 && current_number != 3 -> false
      true -> prime?(current_number, 5)
    end
  end

  defp prime?(current_number, divisor) do
    cond do
      divisor * divisor > current_number -> true
      rem(current_number, divisor) == 0 && current_number != divisor -> false
      rem(current_number, divisor + 2) == 0 && current_number != divisor -> false
      divisor * divisor < current_number -> prime?(current_number, divisor + 6)
    end
  end
end
