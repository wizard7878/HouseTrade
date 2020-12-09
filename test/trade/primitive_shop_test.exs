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
end
