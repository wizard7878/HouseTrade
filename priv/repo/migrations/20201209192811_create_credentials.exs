defmodule Trade.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :email, :string
      add :hash_password, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:credentials, [:user_id])
    create unique_index(:credentials , [:user_id,:email])
  end
end
