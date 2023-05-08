defmodule HighScore do

  @initial_score 0

  def new(), do: %{}

  def add_player(scores, name, score \\ @initial_score), do: scores |> Map.put("#{name}", score)

  def remove_player(scores, name), do: scores |> Map.delete("#{name}")

  def reset_score(scores, name) when is_map_key(scores, name), do: %{ scores | "#{name}" => @initial_score}
  def reset_score(scores, name), do: scores |> add_player(name, @initial_score)

  def update_score(scores, name, score), do: Map.update(scores, name, score, fn n -> n + score end)

  def get_players(scores), do: Map.keys(scores)
end
