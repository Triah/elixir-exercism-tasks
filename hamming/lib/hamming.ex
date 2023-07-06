defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    check_input(strand1, strand2, 0)
  end

  defp check_input([], [], 0), do: {:ok, 0}

  defp check_input([s_one_head | []], [s_two_head | []], count),
    do: if(s_one_head == s_two_head, do: {:ok, count}, else: {:ok, count + 1})

  defp check_input([s_one_head | s_one_tail], [s_two_head | s_two_tail], count) do
    cond do
      s_one_head == s_two_head -> check_input(s_one_tail, s_two_tail, count)
      true -> check_input(s_one_tail, s_two_tail, count + 1)
    end
  end

  defp check_input(_strand1, _strand2, _count), do: {:error, "strands must be of equal length"}
end
