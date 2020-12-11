defmodule Trade.UserAccount.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :fname , :string
    field :lname , :string
    has_one :credentials , Trade.UserAccount.Credentials
    
    timestamps()
  end

  def changeset(struct , params) do
    struct
    |> cast(params , [:fname,:lname])
    |> validate_required([:fname,:lname])
  end
end
