defmodule Trade.Repo.Migrations.RemoveUserAddCredentials do
  use Ecto.Migration

  def change do
    alter table(:porders) do
      remove :user_id, references(:users, on_delete: :nothing)
      add :credential_id , references(:credentials)
    end
    create index(:porders, [:credential_id])
  end
end
