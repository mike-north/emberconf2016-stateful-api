defmodule Pullrequest.RepositoryView do
  use Pullrequest.Web, :view
  use JaSerializer.PhoenixView # Or use in web/web.ex
  import Pullrequest.Router.Helpers

  location :repository_url

  attributes [:name, :description, :homepage, :stargazers_count, :watchers_count]

  has_one :organization, link: :org_url
  has_many :pulls, link: :pulls_url

  def repository_url(r, conn) do
    repository_url(conn, :show, r.id)
  end

  def org_url(o, conn) do
    organization_url(conn, :show, o.organization_id)
  end

  def pulls_url(r, conn) do
    repository_pull_url(conn, :index, r.id)
  end
end
