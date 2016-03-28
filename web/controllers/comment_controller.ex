defmodule Pullrequest.CommentController do
  use Pullrequest.Web, :controller

  alias Pullrequest.Comment

  plug :scrub_params, "comment" when action in [:create, :update]

  def index(conn, %{"pull_id" => pull_id}) do
    query = from(c in Comment, where: c.pull_id == ^pull_id)

    # if params["state"] do
    #   query = from p in query, where: p.state == ^params["state"]
    # end

    # if params["locked"] do
    #   query = from p in query, where: p.locked == ^params["locked"]
    # end

    comments = query |> Repo.all
    render(conn, "index.json", data: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    changeset = Comment.changeset(%Comment{}, comment_params)

    case Repo.insert(changeset) do
      {:ok, comment} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", comment_path(conn, :show, comment))
        |> render("show.json", data: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pullrequest.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)
    render(conn, "show.json", data: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Repo.get!(Comment, id)
    changeset = Comment.changeset(comment, comment_params)

    case Repo.update(changeset) do
      {:ok, comment} ->
        render(conn, "show.json", data: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pullrequest.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    send_resp(conn, :no_content, "")
  end
end
