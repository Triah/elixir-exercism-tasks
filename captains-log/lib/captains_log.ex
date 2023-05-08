defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class(), do: Enum.random(@planetary_classes)

  def random_ship_registry_number(), do: "NCC-#{Enum.random(Enum.to_list(1000..9999))}"

  def random_stardate(), do: :rand.uniform() + Enum.random(Enum.to_list(41000..41999))

  def format_stardate(stardate) do
    # Please implement the format_stardate/1 function
  end
end
