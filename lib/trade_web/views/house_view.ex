defmodule TradeWeb.HouseView do
  use TradeWeb, :view
  alias TradeWeb.HouseView

  def render("index.json", %{houses: houses}) do
    %{data: render_many(houses, HouseView, "house.json")}
  end

  def render("show.json", %{house: house}) do
    %{data: render_one(house, HouseView, "house.json")}
  end

  def render("house.json", %{house: house}) do
    %{id: house.id,
      name: house.name,
      address: house.address,
      number_shares: house.number_shares,
      ordered_shares: house.ordered_shares}
  end
end
