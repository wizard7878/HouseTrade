defmodule Trade.SecondaryShopTest do
  use Trade.DataCase

  alias Trade.SecondaryShop

  describe "sorder" do
    alias Trade.SecondaryShop.SecondaryOrder

    @valid_attrs %{type_order: "some type_order"}
    @update_attrs %{type_order: "some updated type_order"}
    @invalid_attrs %{type_order: nil}

    def secondary_order_fixture(attrs \\ %{}) do
      {:ok, secondary_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SecondaryShop.create_secondary_order()

      secondary_order
    end

    test "list_sorder/0 returns all sorder" do
      secondary_order = secondary_order_fixture()
      assert SecondaryShop.list_sorder() == [secondary_order]
    end

    test "get_secondary_order!/1 returns the secondary_order with given id" do
      secondary_order = secondary_order_fixture()
      assert SecondaryShop.get_secondary_order!(secondary_order.id) == secondary_order
    end

    test "create_secondary_order/1 with valid data creates a secondary_order" do
      assert {:ok, %SecondaryOrder{} = secondary_order} = SecondaryShop.create_secondary_order(@valid_attrs)
      assert secondary_order.type_order == "some type_order"
    end

    test "create_secondary_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SecondaryShop.create_secondary_order(@invalid_attrs)
    end

    test "update_secondary_order/2 with valid data updates the secondary_order" do
      secondary_order = secondary_order_fixture()
      assert {:ok, %SecondaryOrder{} = secondary_order} = SecondaryShop.update_secondary_order(secondary_order, @update_attrs)
      assert secondary_order.type_order == "some updated type_order"
    end

    test "update_secondary_order/2 with invalid data returns error changeset" do
      secondary_order = secondary_order_fixture()
      assert {:error, %Ecto.Changeset{}} = SecondaryShop.update_secondary_order(secondary_order, @invalid_attrs)
      assert secondary_order == SecondaryShop.get_secondary_order!(secondary_order.id)
    end

    test "delete_secondary_order/1 deletes the secondary_order" do
      secondary_order = secondary_order_fixture()
      assert {:ok, %SecondaryOrder{}} = SecondaryShop.delete_secondary_order(secondary_order)
      assert_raise Ecto.NoResultsError, fn -> SecondaryShop.get_secondary_order!(secondary_order.id) end
    end

    test "change_secondary_order/1 returns a secondary_order changeset" do
      secondary_order = secondary_order_fixture()
      assert %Ecto.Changeset{} = SecondaryShop.change_secondary_order(secondary_order)
    end
  end
end
