defmodule Trade.Repo.Migrations.RemoveEmail do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :email , :string
    end
  end
end
