defmodule Pullrequest.Repository do
  use Pullrequest.Web, :model

  schema "repositories" do
    field :name, :string
    field :description, :string
    field :homepage, :string
    belongs_to :organization, Pullrequest.Organization

    timestamps
  end

  @required_fields ~w(name description homepage organization_id)
  @optional_fields ~w()

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
