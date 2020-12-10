defmodule TradeWeb.PrimitiveOrderController do
  use TradeWeb, :controller

  alias Trade.PrimitiveShop
  alias Trade.PrimitiveShop.PrimitiveOrder

  action_fallback TradeWeb.FallbackController

  def index(conn, _params) do
    porders = PrimitiveShop.list_porders()
    render(conn, "index.json", porders: porders)
  end

  def create(conn, %{"primitive_order" => primitive_order_params}) do
    with {:ok, %PrimitiveOrder{} = primitive_order} <- PrimitiveShop.create_primitive_order(primitive_order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.primitive_order_path(conn, :show, primitive_order))
      |> render("show.json", primitive_order: primitive_order)
    end
  end

  def show(conn, %{"id" => id}) do
    primitive_order = PrimitiveShop.get_primitive_order!(id)
    render(conn, "show.json", primitive_order: primitive_order)
  end

  def update(conn, %{"id" => id, "primitive_order" => primitive_order_params}) do
    primitive_order = PrimitiveShop.get_primitive_order!(id)

    with {:ok, %PrimitiveOrder{} = primitive_order} <- PrimitiveShop.update_primitive_order(primitive_order, primitive_order_params) do
      render(conn, "show.json", primitive_order: primitive_order)
    end
  end

  def delete(conn, %{"id" => id}) do
    primitive_order = PrimitiveShop.get_primitive_order!(id)

    with {:ok, %PrimitiveOrder{}} <- PrimitiveShop.delete_primitive_order(primitive_order) do
      send_resp(conn, :no_content, "")
    end
  end
end
