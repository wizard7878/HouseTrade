defmodule Trade.PrimitiveShop.PrimitiveOrder do
  use Ecto.Schema
  import Ecto.Changeset
  alias Trade.UserAccount.User
  alias Trade.PrimitiveShop.House
  
  schema "porders" do
    field :number_share, :integer
    field :type_order, :string
    belongs_to :user_id, User
    belongs_to :house_id, House

    timestamps()
  end

  @doc false
  def changeset(primitive_order, attrs) do
    primitive_order
    |> cast(attrs, [:number_share, :type_order])
    |> validate_required([:number_share, :type_order])
  end
end
