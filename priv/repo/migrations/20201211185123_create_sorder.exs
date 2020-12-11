defmodule Trade.Repo.Migrations.CreateSorder do
  use Ecto.Migration

  def change do
    create table(:sorder) do
      add :type_order, :string
      add :number_share , :integer
      add :credential_id, references(:credentials, on_delete: :nothing)
      add :house_id, references(:houses, on_delete: :nothing)

      timestamps()
    end

    create index(:sorder, [:credential_id])
    create index(:sorder, [:house_id])
  end
end
