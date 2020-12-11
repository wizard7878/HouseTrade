defmodule TradeWeb.SecondaryOrderView do
  use TradeWeb, :view
  alias TradeWeb.SecondaryOrderView

  def render("index.json", %{sorder: sorder}) do
    %{data: render_many(sorder, SecondaryOrderView, "secondary_order.json")}
  end

  def render("show.json", %{secondary_order: secondary_order}) do
    %{data: render_one(secondary_order, SecondaryOrderView, "secondary_order.json")}
  end

  def render("error.json", %{error: error_message}) do
    %{error: error_message}
  end

  def render("secondary_order.json", %{secondary_order: secondary_order}) do
    %{
      id: secondary_order.id,
      number_share: secondary_order.number_share,
      type_order: secondary_order.type_order,
      user: %{
        first_name: secondary_order.credential.user.fname,
        last_name: secondary_order.credential.user.lname,
        email: secondary_order.credential.email,
      },

      house: %{
        name: secondary_order.house.name,
        address: secondary_order.house.address
      }
    }
  end
end
