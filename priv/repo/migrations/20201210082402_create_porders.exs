defmodule Trade.Repo.Migrations.CreatePorders do
  use Ecto.Migration

  def change do
    create table(:porders) do
      add :number_share, :integer
      add :type_order, :string , default: "Buy"
      add :user_id, references(:users, on_delete: :nothing)
      add :house_id, references(:houses, on_delete: :nothing)

      timestamps()
    end


    create index(:porders, [:user_id])
    create index(:porders, [:house_id])
  end
end
