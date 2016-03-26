import Ecto.Query, only: [from: 2]

defmodule Pullrequest.PullController do
  use Pullrequest.Web, :controller

  alias Pullrequest.Pull

  plug :scrub_params, "pull" when action in [:create, :update]

  def index(conn, %{"repository_id" => repo_id} = params) do

    query = from(p in Pull, where: p.repository_id == ^repo_id)

    if params["state"] do
      query = from p in query, where: p.state == ^params["state"]
    end

    if params["locked"] do
      query = from p in query, where: p.locked == ^params["locked"]
    end

    pulls = query |> Repo.all

    render(conn, "index.json", data: pulls)
  end

  def show(conn, %{"id" => id}) do
    pull = Repo.get!(Pull, id)
    render(conn, "show.json", data: pull)
  end

  def update(conn, %{"id" => id, "pull" => pull_params}) do
    pull = Repo.get!(Pull, id)
    changeset = Pull.changeset(pull, pull_params)

    case Repo.update(changeset) do
      {:ok, pull} ->
        render(conn, "show.json", data: pull)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pullrequest.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pull = Repo.get!(Pull, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(pull)

    send_resp(conn, :no_content, "")
  end
end
