defmodule Pullrequest.Repo.Migrations.CreateRepository do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add :name, :string
      add :description, :string
      add :homepage, :string
      add :organization_id, references(:organizations, on_delete: :nothing)

      timestamps
    end
    create index(:repositories, [:organization_id])

  end
end
