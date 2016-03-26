defmodule Pullrequest.PullView do
  use Pullrequest.Web, :view
  use JaSerializer.PhoenixView
  import Pullrequest.Router.Helpers

  location :pull_url

  attributes [:title, :body, :locked, :state]

  has_one :repository, link: :repo_url

  def pull_url(p, conn) do
    pull_url(conn, :show, p.id)
  end

  def repo_url(p, conn) do
    repository_url(conn, :show, p.repository_id)
  end
end
