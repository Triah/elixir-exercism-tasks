defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ [maximum_price: 100]) do
    for t <- tops,
        b <- bottoms,
        t.base_color != b.base_color,
        options[:maximum_price] != nil and t.price + b.price <= options[:maximum_price] do
      {t, b}
    end
  end
end
