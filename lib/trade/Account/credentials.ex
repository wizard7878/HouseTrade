defmodule Trade.UserAccount.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Trade.UserAccount.User

  schema "credentials" do
    field :email, :string
    field :hash_password, :string
    field :password , :string , virtual: true
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email,~r/@/)
    |> validate_confirmation(:password)
    |> unique_constraint([:user,:email])
    |> put_password_hash
  end


  def put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset,:hash_password,Bcrypt.hash_pwd_salt(pass))
        _ ->
          changeset
    end
  end
end
