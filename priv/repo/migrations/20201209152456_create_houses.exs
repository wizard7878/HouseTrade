defmodule Trade.Repo.Migrations.CreateHouses do
  use Ecto.Migration

  def change do
    create table(:houses) do
      add :name, :string
      add :address, :string
      add :number_shares, :integer
      add :ordered_shares, :integer

      timestamps()
    end

  end
end
