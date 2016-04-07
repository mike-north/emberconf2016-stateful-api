defmodule Pullrequest.RepositoryController do
  use Pullrequest.Web, :controller

  alias Pullrequest.Repository

  plug :scrub_params, "repository" when action in [:create, :update]

  def index(conn, %{"organization_id" => organization_id}) do
    query = from(c in Repository, where: c.organization_id == ^organization_id)
    # :timer.sleep(3000)
    # if params["state"] do
    #   query = from p in query, where: p.state == ^params["state"]
    # end

    # if params["locked"] do
    #   query = from p in query, where: p.locked == ^params["locked"]
    # end

    repositories = query |> Repo.all
    render(conn, "index.json", data: repositories)
  end

  def create(conn, %{"organization_id" => org_id, "repository" => repository_params}) do
    changeset = Repository.changeset(%Repository{}, repository_params)

    case Repo.insert(changeset) do
      {:ok, repository} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", organization_repository_path(conn, :show, org_id, repository))
        |> render("show.json", data: repository)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pullrequest.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    :timer.sleep(3000)
    repository = Repo.get!(Repository, id)
    render(conn, "show.json", data: repository)
  end

  def update(conn, %{"id" => id, "repository" => repository_params}) do
    repository = Repo.get!(Repository, id)
    changeset = Repository.changeset(repository, repository_params)

    case Repo.update(changeset) do
      {:ok, repository} ->
        render(conn, "show.json", data: repository)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pullrequest.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    repository = Repo.get!(Repository, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(repository)

    send_resp(conn, :no_content, "")
  end
end
