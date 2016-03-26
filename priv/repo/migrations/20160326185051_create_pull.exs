defmodule Pullrequest.Repo.Migrations.CreatePull do
  use Ecto.Migration

  def change do
    create table(:pulls) do
      add :title, :string
      add :body, :string, size: 10000
      add :state, :string
      add :locked, :boolean, default: false
      add :repository_id, references(:repositories, on_delete: :nothing)

      timestamps
    end
    create index(:pulls, [:repository_id])

  end
end
