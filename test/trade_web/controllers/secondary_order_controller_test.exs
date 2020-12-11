defmodule TradeWeb.SecondaryOrderControllerTest do
  use TradeWeb.ConnCase

  alias Trade.SecondaryShop
  alias Trade.SecondaryShop.SecondaryOrder

  @create_attrs %{
    type_order: "some type_order"
  }
  @update_attrs %{
    type_order: "some updated type_order"
  }
  @invalid_attrs %{type_order: nil}

  def fixture(:secondary_order) do
    {:ok, secondary_order} = SecondaryShop.create_secondary_order(@create_attrs)
    secondary_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sorder", %{conn: conn} do
      conn = get(conn, Routes.secondary_order_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create secondary_order" do
    test "renders secondary_order when data is valid", %{conn: conn} do
      conn = post(conn, Routes.secondary_order_path(conn, :create), secondary_order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.secondary_order_path(conn, :show, id))

      assert %{
               "id" => id,
               "type_order" => "some type_order"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.secondary_order_path(conn, :create), secondary_order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update secondary_order" do
    setup [:create_secondary_order]

    test "renders secondary_order when data is valid", %{conn: conn, secondary_order: %SecondaryOrder{id: id} = secondary_order} do
      conn = put(conn, Routes.secondary_order_path(conn, :update, secondary_order), secondary_order: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.secondary_order_path(conn, :show, id))

      assert %{
               "id" => id,
               "type_order" => "some updated type_order"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, secondary_order: secondary_order} do
      conn = put(conn, Routes.secondary_order_path(conn, :update, secondary_order), secondary_order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete secondary_order" do
    setup [:create_secondary_order]

    test "deletes chosen secondary_order", %{conn: conn, secondary_order: secondary_order} do
      conn = delete(conn, Routes.secondary_order_path(conn, :delete, secondary_order))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.secondary_order_path(conn, :show, secondary_order))
      end
    end
  end

  defp create_secondary_order(_) do
    secondary_order = fixture(:secondary_order)
    %{secondary_order: secondary_order}
  end
end
