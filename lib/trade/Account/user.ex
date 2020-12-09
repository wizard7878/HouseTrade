defmodule Trade.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :fname , :string
    field :lname , :string
    field :email , :string

    timestamps()
  end

  def changeset(struct , params) do
    struct
    |> cast(params , [:fname,:lname,:email])
    |> validate_required([:fname,:lname,:email])
    |> unique_constraint([:email])
    |> validate_format(:email,~r/@/)
  end
end
