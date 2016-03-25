defmodule Pullrequest.RepositoryTest do
  use Pullrequest.ModelCase

  alias Pullrequest.Repository

  @valid_attrs %{description: "some content", homepage: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Repository.changeset(%Repository{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Repository.changeset(%Repository{}, @invalid_attrs)
    refute changeset.valid?
  end
end
