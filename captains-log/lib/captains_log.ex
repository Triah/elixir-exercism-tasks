defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class(), do: Enum.random(@planetary_classes)

  def random_ship_registry_number(), do: "NCC-#{Enum.random(Enum.to_list(1000..9999))}"

  def random_stardate(), do: :rand.uniform() * 1000 + 41000

  def format_stardate(stardate), do: to_string(:io_lib.format("~.1f", [stardate]))
end
