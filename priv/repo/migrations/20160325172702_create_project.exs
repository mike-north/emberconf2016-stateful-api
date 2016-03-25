defmodule Pullrequest.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :icon_url, :string

      timestamps
    end

  end
end
