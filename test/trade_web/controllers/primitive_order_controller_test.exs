defmodule TradeWeb.PrimitiveOrderControllerTest do
  use TradeWeb.ConnCase

  alias Trade.PrimitiveShop
  alias Trade.PrimitiveShop.PrimitiveOrder

  @create_attrs %{
    number_share: 42,
    type_order: "some type_order"
  }
  @update_attrs %{
    number_share: 43,
    type_order: "some updated type_order"
  }
  @invalid_attrs %{number_share: nil, type_order: nil}

  def fixture(:primitive_order) do
    {:ok, primitive_order} = PrimitiveShop.create_primitive_order(@create_attrs)
    primitive_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all porders", %{conn: conn} do
      conn = get(conn, Routes.primitive_order_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create primitive_order" do
    test "renders primitive_order when data is valid", %{conn: conn} do
      conn = post(conn, Routes.primitive_order_path(conn, :create), primitive_order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.primitive_order_path(conn, :show, id))

      assert %{
               "id" => id,
               "number_share" => 42,
               "type_order" => "some type_order"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.primitive_order_path(conn, :create), primitive_order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update primitive_order" do
    setup [:create_primitive_order]

    test "renders primitive_order when data is valid", %{conn: conn, primitive_order: %PrimitiveOrder{id: id} = primitive_order} do
      conn = put(conn, Routes.primitive_order_path(conn, :update, primitive_order), primitive_order: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.primitive_order_path(conn, :show, id))

      assert %{
               "id" => id,
               "number_share" => 43,
               "type_order" => "some updated type_order"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, primitive_order: primitive_order} do
      conn = put(conn, Routes.primitive_order_path(conn, :update, primitive_order), primitive_order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete primitive_order" do
    setup [:create_primitive_order]

    test "deletes chosen primitive_order", %{conn: conn, primitive_order: primitive_order} do
      conn = delete(conn, Routes.primitive_order_path(conn, :delete, primitive_order))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.primitive_order_path(conn, :show, primitive_order))
      end
    end
  end

  defp create_primitive_order(_) do
    primitive_order = fixture(:primitive_order)
    %{primitive_order: primitive_order}
  end
end
