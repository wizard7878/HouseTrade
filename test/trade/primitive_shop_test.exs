defmodule Trade.PrimitiveShopTest do
  use Trade.DataCase

  alias Trade.PrimitiveShop

  describe "houses" do
    alias Trade.PrimitiveShop.House

    @valid_attrs %{address: "some address", name: "some name", number_shares: 42, ordered_shares: 42}
    @update_attrs %{address: "some updated address", name: "some updated name", number_shares: 43, ordered_shares: 43}
    @invalid_attrs %{address: nil, name: nil, number_shares: nil, ordered_shares: nil}

    def house_fixture(attrs \\ %{}) do
      {:ok, house} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PrimitiveShop.create_house()

      house
    end

    test "list_houses/0 returns all houses" do
      house = house_fixture()
      assert PrimitiveShop.list_houses() == [house]
    end

    test "get_house!/1 returns the house with given id" do
      house = house_fixture()
      assert PrimitiveShop.get_house!(house.id) == house
    end

    test "create_house/1 with valid data creates a house" do
      assert {:ok, %House{} = house} = PrimitiveShop.create_house(@valid_attrs)
      assert house.address == "some address"
      assert house.name == "some name"
      assert house.number_shares == 42
      assert house.ordered_shares == 42
    end

    test "create_house/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PrimitiveShop.create_house(@invalid_attrs)
    end

    test "update_house/2 with valid data updates the house" do
      house = house_fixture()
      assert {:ok, %House{} = house} = PrimitiveShop.update_house(house, @update_attrs)
      assert house.address == "some updated address"
      assert house.name == "some updated name"
      assert house.number_shares == 43
      assert house.ordered_shares == 43
    end

    test "update_house/2 with invalid data returns error changeset" do
      house = house_fixture()
      assert {:error, %Ecto.Changeset{}} = PrimitiveShop.update_house(house, @invalid_attrs)
      assert house == PrimitiveShop.get_house!(house.id)
    end

    test "delete_house/1 deletes the house" do
      house = house_fixture()
      assert {:ok, %House{}} = PrimitiveShop.delete_house(house)
      assert_raise Ecto.NoResultsError, fn -> PrimitiveShop.get_house!(house.id) end
    end

    test "change_house/1 returns a house changeset" do
      house = house_fixture()
      assert %Ecto.Changeset{} = PrimitiveShop.change_house(house)
    end
  end

  describe "porders" do
    alias Trade.PrimitiveShop.PrimitiveOrder

    @valid_attrs %{number_share: 42, type_order: "some type_order"}
    @update_attrs %{number_share: 43, type_order: "some updated type_order"}
    @invalid_attrs %{number_share: nil, type_order: nil}

    def primitive_order_fixture(attrs \\ %{}) do
      {:ok, primitive_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PrimitiveShop.create_primitive_order()

      primitive_order
    end

    test "list_porders/0 returns all porders" do
      primitive_order = primitive_order_fixture()
      assert PrimitiveShop.list_porders() == [primitive_order]
    end

    test "get_primitive_order!/1 returns the primitive_order with given id" do
      primitive_order = primitive_order_fixture()
      assert PrimitiveShop.get_primitive_order!(primitive_order.id) == primitive_order
    end

    test "create_primitive_order/1 with valid data creates a primitive_order" do
      assert {:ok, %PrimitiveOrder{} = primitive_order} = PrimitiveShop.create_primitive_order(@valid_attrs)
      assert primitive_order.number_share == 42
      assert primitive_order.type_order == "some type_order"
    end

    test "create_primitive_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PrimitiveShop.create_primitive_order(@invalid_attrs)
    end

    test "update_primitive_order/2 with valid data updates the primitive_order" do
      primitive_order = primitive_order_fixture()
      assert {:ok, %PrimitiveOrder{} = primitive_order} = PrimitiveShop.update_primitive_order(primitive_order, @update_attrs)
      assert primitive_order.number_share == 43
      assert primitive_order.type_order == "some updated type_order"
    end

    test "update_primitive_order/2 with invalid data returns error changeset" do
      primitive_order = primitive_order_fixture()
      assert {:error, %Ecto.Changeset{}} = PrimitiveShop.update_primitive_order(primitive_order, @invalid_attrs)
      assert primitive_order == PrimitiveShop.get_primitive_order!(primitive_order.id)
    end

    test "delete_primitive_order/1 deletes the primitive_order" do
      primitive_order = primitive_order_fixture()
      assert {:ok, %PrimitiveOrder{}} = PrimitiveShop.delete_primitive_order(primitive_order)
      assert_raise Ecto.NoResultsError, fn -> PrimitiveShop.get_primitive_order!(primitive_order.id) end
    end

    test "change_primitive_order/1 returns a primitive_order changeset" do
      primitive_order = primitive_order_fixture()
      assert %Ecto.Changeset{} = PrimitiveShop.change_primitive_order(primitive_order)
    end
  end
end
