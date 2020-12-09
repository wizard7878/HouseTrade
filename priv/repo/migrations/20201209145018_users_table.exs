defmodule Trade.Repo.Migrations.UsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :fname , :string
      add :lname , :string
      add :email , :string

      timestamps()
    end

    create unique_index(:users , [:email])
  end
end
