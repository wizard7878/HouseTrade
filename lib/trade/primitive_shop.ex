defmodule Trade.PrimitiveShop do

  import Ecto.Query, warn: false
  alias Trade.Repo

  alias Trade.PrimitiveShop.House


  def list_houses do
    Repo.all(House)
  end


  def get_house!(id), do: Repo.get!(House, id)


  def create_house(attrs \\ %{}) do
    %House{}
    |> House.changeset(attrs)
    |> Repo.insert()
  end


  def update_house(%House{} = house, attrs) do
    house
    |> House.changeset(attrs)
    |> Repo.update()
  end


  def delete_house(%House{} = house) do
    Repo.delete(house)
  end


  def change_house(%House{} = house, attrs \\ %{}) do
    House.changeset(house, attrs)
  end

  alias Trade.PrimitiveShop.PrimitiveOrder


  def list_porders do
    PrimitiveOrder
    |> Repo.all()
    |> Repo.preload(credential: :user)
    |> Repo.preload(:house)
  end


  def get_primitive_order!(id) do
    PrimitiveOrder
    |> Repo.get(id)
    |> Repo.preload(credential: :user)
    |> Repo.preload(:house)

  end



  def create_primitive_order(attrs \\ %{},user) do
    house = Repo.get(House,attrs["house_id"])
    if house.number_shares >= attrs["number_share"] do
      %PrimitiveOrder{}
      |> PrimitiveOrder.changeset(attrs)
      |> Ecto.Changeset.put_change(:house_id,house.id)
      |> Ecto.Changeset.put_change(:credential_id,user.id)
      |> Repo.insert()
    else
      nil
    end

  end

  def update_house_info_after_order(attrs) do
    house = Repo.get(House,attrs["house_id"])
    number_shares = house.number_shares - attrs["number_share"]
    ordered_shares = house.ordered_shares + attrs["number_share"]
    House.changeset(house ,%{number_shares: number_shares , ordered_shares: ordered_shares})
    |> Repo.update()
  end


  def delete_primitive_order(%PrimitiveOrder{} = primitive_order) do
    house = Repo.get(House,primitive_order.house_id)
    number_shares = house.number_shares + primitive_order.number_share
    ordered_shares = house.ordered_shares - primitive_order.number_share
    House.changeset(house ,%{number_shares: number_shares , ordered_shares: ordered_shares})
    |> Repo.update()
    Repo.delete(primitive_order)
  end


  def change_primitive_order(%PrimitiveOrder{} = primitive_order, attrs \\ %{}) do
    PrimitiveOrder.changeset(primitive_order, attrs)
  end
end
