defmodule Pullrequest.Comment do
  use Pullrequest.Web, :model

  schema "comments" do
    field :body, :string
    field :diff_hunk, :string
    field :commit_id, :string
    field :path, :string
    belongs_to :pull, Pullrequest.Pull

    timestamps
  end

  @required_fields ~w(body)
  @optional_fields ~w(diff_hunk commit_id path)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:body, min: 1)
  end
end
