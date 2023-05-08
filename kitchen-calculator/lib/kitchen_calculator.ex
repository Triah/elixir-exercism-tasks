defmodule KitchenCalculator do
  def get_volume(volume_pair), do: elem(volume_pair, 1)

  def to_milliliter(volume_pair) do
    case elem(volume_pair,0) do
      :cup -> {:milliliter, get_volume(volume_pair) * 240}
      :milliliter -> {:milliliter, get_volume(volume_pair)}
      :fluid_ounce -> {:milliliter, get_volume(volume_pair) * 30}
      :teaspoon -> {:milliliter, get_volume(volume_pair) * 5}
      :tablespoon -> {:milliliter, get_volume(volume_pair) * 15}
    end
  end

  def from_milliliter(volume_pair, unit) do
    case unit do
      :cup -> {:cup, get_volume(volume_pair) / 240}
      :milliliter -> {:milliliter, get_volume(volume_pair)}
      :fluid_ounce -> {:fluid_ounce, get_volume(volume_pair) / 30}
      :teaspoon -> {:teaspoon, get_volume(volume_pair) / 5}
      :tablespoon -> {:tablespoon, get_volume(volume_pair) / 15}
    end
  end

  def convert(volume_pair, unit), do: from_milliliter(to_milliliter(volume_pair), unit)
end
