defmodule Trade.UserAccount do
  alias Trade.Repo
  alias Trade.UserAccount.{User,Credential}
  alias Trade.Guardian


  def createuser(params) do
    changeset = Credential.changeset(%Credential{} , params)
    |> Ecto.Changeset.cast_assoc(:user , with: &User.changeset/2)
    |> IO.inspect()
    with {:ok,user}          <- Repo.insert(changeset) ,
         {:ok,token,_claims} <- Guardian.encode_and_sign(user)  do
      token
    end
  end

  def login_user(email,password) do
    user = Repo.get_by!(Credential,email: email)
    if Bcrypt.verify_pass(password , user.hash_password) do
      with {:ok,token,_a} <- Trade.Guardian.encode_and_sign(user) do
        token
      end
    else
      "Wrong Password"
    end
  end

  def list_credentials do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)


  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end


  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end


  def delete_user(%User{} = user) do
    Repo.delete(user)
  end


  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
