defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, &(&1.price))

  def with_missing_price(inventory), do: Enum.filter(inventory, fn x -> x.price == nil end)

  def update_names(inventory, old_word, new_word), do: Enum.map(inventory, fn x -> Map.replace(x, :name, String.replace(x.name, old_word, new_word)) end)

  def increase_quantity(item, count), do: Map.replace(item, :quantity_by_size, Map.new(item[:quantity_by_size], fn {k,v} -> {k, v+count} end))

  def total_quantity(item), do: Enum.reduce(item.quantity_by_size, 0, fn {_size, amount}, total -> amount + total end) 
end
