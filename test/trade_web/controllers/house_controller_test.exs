defmodule TradeWeb.HouseControllerTest do
  use TradeWeb.ConnCase

  alias Trade.PrimitiveShop
  alias Trade.PrimitiveShop.House

  @create_attrs %{
    address: "some address",
    name: "some name",
    number_shares: 42,
    ordered_shares: 42
  }
  @update_attrs %{
    address: "some updated address",
    name: "some updated name",
    number_shares: 43,
    ordered_shares: 43
  }
  @invalid_attrs %{address: nil, name: nil, number_shares: nil, ordered_shares: nil}

  def fixture(:house) do
    {:ok, house} = PrimitiveShop.create_house(@create_attrs)
    house
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all houses", %{conn: conn} do
      conn = get(conn, Routes.house_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create house" do
    test "renders house when data is valid", %{conn: conn} do
      conn = post(conn, Routes.house_path(conn, :create), house: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.house_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some address",
               "name" => "some name",
               "number_shares" => 42,
               "ordered_shares" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.house_path(conn, :create), house: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update house" do
    setup [:create_house]

    test "renders house when data is valid", %{conn: conn, house: %House{id: id} = house} do
      conn = put(conn, Routes.house_path(conn, :update, house), house: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.house_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some updated address",
               "name" => "some updated name",
               "number_shares" => 43,
               "ordered_shares" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, house: house} do
      conn = put(conn, Routes.house_path(conn, :update, house), house: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete house" do
    setup [:create_house]

    test "deletes chosen house", %{conn: conn, house: house} do
      conn = delete(conn, Routes.house_path(conn, :delete, house))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.house_path(conn, :show, house))
      end
    end
  end

  defp create_house(_) do
    house = fixture(:house)
    %{house: house}
  end
end
