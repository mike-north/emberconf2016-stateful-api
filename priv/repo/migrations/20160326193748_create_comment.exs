defmodule Pullrequest.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string, size: 20384
      add :diff_hunk, :string, size: 20384
      add :commit_id, :string
      add :path, :string, size: 5096
      add :pull_id, references(:pulls, on_delete: :nothing)

      timestamps
    end
    create index(:comments, [:pull_id])

  end
end
