defmodule Pullrequest.CommentTest do
  use Pullrequest.ModelCase

  alias Pullrequest.Comment

  @valid_attrs %{body: "some content", commit_id: "some content", diff_hunk: "some content", path: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Comment.changeset(%Comment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Comment.changeset(%Comment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
