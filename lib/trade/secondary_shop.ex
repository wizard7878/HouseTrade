defmodule Trade.SecondaryShop do


  import Ecto.Query, warn: false
  alias Trade.Repo

  alias Trade.SecondaryShop.SecondaryOrder
  alias Trade.PrimitiveShop.House

  def list_sorder do
    SecondaryOrder
    |> Repo.all()
    |> Repo.preload(credential: :user)
    |> Repo.preload(:house)
  end


  def get_secondary_order!(id) do
    SecondaryOrder
    |> Repo.get!(id)
    |> Repo.preload(credential: :user)
    |> Repo.preload(:house)
  end


  def create_secondary_order(attrs \\ %{} , user) do
      house = Repo.get(House,attrs["house_id"])
      if house != nil && house.number_shares >= attrs["number_share"] do
        %SecondaryOrder{}
        |> SecondaryOrder.changeset(attrs)
        |> Ecto.Changeset.put_change(:house_id,house.id)
        |> Ecto.Changeset.put_change(:credential_id,user.id)
        |> Repo.insert()
      else
        {:error , "Something Went Wrong!"}
      end

  end

  def update_secondary_order(%SecondaryOrder{} = secondary_order, attrs) do
    if Repo.get(House,attrs["house_id"]) do
        secondary_order
        |> SecondaryOrder.changeset(attrs)
        |> Ecto.Changeset.put_change(:house_id,attrs["house_id"])
        |> Repo.update()
    else
        {:error , "Something Went Wrong!"}
    end
  end


  def delete_secondary_order(%SecondaryOrder{} = secondary_order) do
    Repo.delete(secondary_order)
  end


  def change_secondary_order(%SecondaryOrder{} = secondary_order, attrs \\ %{}) do
    SecondaryOrder.changeset(secondary_order, attrs)
  end
end
