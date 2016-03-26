defmodule Pullrequest.PullTest do
  use Pullrequest.ModelCase

  alias Pullrequest.Pull

  @valid_attrs %{body: "some content", locked: true, state: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pull.changeset(%Pull{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pull.changeset(%Pull{}, @invalid_attrs)
    refute changeset.valid?
  end
end
