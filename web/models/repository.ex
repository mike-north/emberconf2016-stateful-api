defmodule Pullrequest.Repository do
  use Pullrequest.Web, :model

  schema "repositories" do
    field :name, :string
    field :description, :string
    field :homepage, :string
    field :stargazers_count, :integer
    field :watchers_count, :integer
    belongs_to :organization, Pullrequest.Organization
    has_many :pulls, Pullrequest.Pull

    timestamps
  end

  @required_fields ~w(name description homepage organization_id)
  @optional_fields ~w(stargazers_count watchers_count)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
