defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    dist = distance_from_mid({x, y})

    cond do
      dist > 10.0 -> 0
      dist > 5.0 -> 1
      dist > 1.0 -> 5
      true -> 10
    end
  end

  defp distance_from_mid({0, y}), do: abs(y) / 1
  defp distance_from_mid({x, 0}), do: abs(x) / 1

  defp distance_from_mid({x, y}),
    do: (:math.pow(x, 2) + :math.pow(y, 2)) |> :math.sqrt()
end
