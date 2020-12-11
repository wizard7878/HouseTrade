defmodule TradeWeb.PrimitiveOrderView do
  use TradeWeb, :view
  alias TradeWeb.PrimitiveOrderView

  def render("index.json", %{porders: porders}) do
    %{data: render_many(porders, PrimitiveOrderView, "primitive_order.json")}
  end

  def render("show.json", %{primitive_order: primitive_order}) do
    %{data: render_one(primitive_order, PrimitiveOrderView, "primitive_order.json")}
  end

  def render("error.json" , %{error: msg}) do
    %{error: msg}
  end

  def render("primitive_order.json", %{primitive_order: primitive_order}) do
    %{id: primitive_order.id,
    user: %{
      First_name: primitive_order.credential.user.fname,
      Last_name: primitive_order.credential.user.lname,
      Email: primitive_order.credential.email
    },
    house: %{
      Name: primitive_order.house.name,
      Address: primitive_order.house.address
    },
      number_share: primitive_order.number_share,
      type_order: primitive_order.type_order}
  end
end
