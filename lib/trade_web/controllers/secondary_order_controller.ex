defmodule TradeWeb.SecondaryOrderController do
  use TradeWeb, :controller

  alias Trade.SecondaryShop
  alias Trade.SecondaryShop.SecondaryOrder
  alias Trade.Repo
  action_fallback TradeWeb.FallbackController

  def index(conn, _params) do
    sorder = SecondaryShop.list_sorder()
    render(conn, "index.json", sorder: sorder)
  end

  def create(conn, %{"secondary_order" => secondary_order_params}) do
    user = conn.private[:guardian_default_resource]
    case SecondaryShop.create_secondary_order(secondary_order_params , user) do
      {:ok, %SecondaryOrder{} = secondary_order} ->
        secondary_order = secondary_order
        |> Repo.preload(credential: :user)
        |> Repo.preload(:house)

        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.secondary_order_path(conn, :show, secondary_order))
        |> render("show.json", secondary_order: secondary_order)
      {:error , resaon} ->
        render(conn , "error.json", error: resaon)
    end
  end

  def show(conn, %{"id" => id}) do
    secondary_order = SecondaryShop.get_secondary_order!(id)
    if secondary_order == nil do
      render(conn, "show.json", secondary_order: secondary_order)
    end
    render(conn, "error.json", error: "404 Notfound!")
  end

  def update(conn, %{"id" => id, "secondary_order" => secondary_order_params}) do
    secondary_order = SecondaryShop.get_secondary_order!(id)

    case  SecondaryShop.update_secondary_order(secondary_order, secondary_order_params) do
      {:ok, %SecondaryOrder{} = secondary_order} ->
        render(conn, "show.json", secondary_order: secondary_order)
      {:error , changeset} ->
        render(conn , "error.json" , error: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    secondary_order = SecondaryShop.get_secondary_order!(id)

    with {:ok, %SecondaryOrder{}} <- SecondaryShop.delete_secondary_order(secondary_order) do
      send_resp(conn, :no_content, "")
    end
  end
end
