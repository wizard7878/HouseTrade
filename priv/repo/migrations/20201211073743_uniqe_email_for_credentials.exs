defmodule Trade.Repo.Migrations.UniqeEmailForCredentials do
  use Ecto.Migration

  def change do
    alter table(:credentials) do
      remove :email, :string
      add :email, :string
    end
    create unique_index(:credentials , [:email])
  end
end
