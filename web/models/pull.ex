defmodule Pullrequest.Pull do
  use Pullrequest.Web, :model

  schema "pulls" do
    field :title, :string
    field :body, :string
    field :state, :string
    field :locked, :boolean, default: false
    belongs_to :repository, Pullrequest.Repository

    timestamps
  end

  @required_fields ~w(title body state locked repository_id)
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
