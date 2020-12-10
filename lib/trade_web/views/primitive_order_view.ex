defmodule TradeWeb.PrimitiveOrderView do
  use TradeWeb, :view
  alias TradeWeb.PrimitiveOrderView

  def render("index.json", %{porders: porders}) do
    %{data: render_many(porders, PrimitiveOrderView, "primitive_order.json")}
  end

  def render("show.json", %{primitive_order: primitive_order}) do
    %{data: render_one(primitive_order, PrimitiveOrderView, "primitive_order.json")}
  end

  def render("primitive_order.json", %{primitive_order: primitive_order}) do
    %{id: primitive_order.id,
      number_share: primitive_order.number_share,
      type_order: primitive_order.type_order}
  end
end
