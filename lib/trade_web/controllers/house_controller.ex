defmodule TradeWeb.HouseController do
  use TradeWeb, :controller

  alias Trade.PrimitiveShop
  alias Trade.PrimitiveShop.House

  action_fallback TradeWeb.FallbackController

  def index(conn, _params) do
    houses = PrimitiveShop.list_houses()
    render(conn, "index.json", houses: houses)
  end

  def create(conn, %{"house" => house_params}) do
    with {:ok, %House{} = house} <- PrimitiveShop.create_house(house_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.house_path(conn, :show, house))
      |> render("show.json", house: house)
    end
  end

  def show(conn, %{"id" => id}) do
    house = PrimitiveShop.get_house!(id)
    render(conn, "show.json", house: house)
  end

  def update(conn, %{"id" => id, "house" => house_params}) do
    house = PrimitiveShop.get_house!(id)

    with {:ok, %House{} = house} <- PrimitiveShop.update_house(house, house_params) do
      render(conn, "show.json", house: house)
    end
  end

  def delete(conn, %{"id" => id}) do
    house = PrimitiveShop.get_house!(id)

    with {:ok, %House{}} <- PrimitiveShop.delete_house(house) do
      send_resp(conn, :no_content, "")
    end
  end
end
