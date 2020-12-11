defmodule Trade.PrimitiveShop.House do
  use Ecto.Schema
  import Ecto.Changeset

  schema "houses" do
    field :address, :string
    field :name, :string
    field :number_shares, :integer
    field :ordered_shares, :integer
    has_many :porders , Trade.PrimitiveShop.PrimitiveOrder
    has_many :sorder , Trade.SecondaryShop.SecondaryOrder
    timestamps()
  end

  @doc false
  def changeset(house, attrs) do
    house
    |> cast(attrs, [:name, :address, :number_shares, :ordered_shares])
    |> validate_required([:name, :address, :number_shares, :ordered_shares])
  end
end
