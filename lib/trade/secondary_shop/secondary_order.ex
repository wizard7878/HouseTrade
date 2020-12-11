defmodule Trade.SecondaryShop.SecondaryOrder do
  use Ecto.Schema
  import Ecto.Changeset
  alias Trade.UserAccount.Credential
  alias Trade.PrimitiveShop.House

  schema "sorder" do
    field :type_order, :string
    field :number_share , :integer
    belongs_to :credential, Credential
    belongs_to :house, House

    timestamps()
  end

  @doc false
  def changeset(secondary_order, attrs) do
    secondary_order
    |> cast(attrs, [:type_order,:number_share])
    |> validate_required([:type_order,:number_share])
  end
end
