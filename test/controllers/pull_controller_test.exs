defmodule Pullrequest.PullControllerTest do
  use Pullrequest.ConnCase

  alias Pullrequest.Pull
  @valid_attrs %{body: "some content", locked: true, state: "some content", title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, pull_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    pull = Repo.insert! %Pull{}
    conn = get conn, pull_path(conn, :show, pull)
    assert json_response(conn, 200)["data"] == %{"id" => pull.id,
      "title" => pull.title,
      "body" => pull.body,
      "state" => pull.state,
      "locked" => pull.locked}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, pull_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, pull_path(conn, :create), pull: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Pull, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, pull_path(conn, :create), pull: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    pull = Repo.insert! %Pull{}
    conn = put conn, pull_path(conn, :update, pull), pull: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Pull, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    pull = Repo.insert! %Pull{}
    conn = put conn, pull_path(conn, :update, pull), pull: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    pull = Repo.insert! %Pull{}
    conn = delete conn, pull_path(conn, :delete, pull)
    assert response(conn, 204)
    refute Repo.get(Pull, pull.id)
  end
end
