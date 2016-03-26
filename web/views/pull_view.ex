defmodule Pullrequest.PullView do
  use Pullrequest.Web, :view
  use JaSerializer.PhoenixView
  import Pullrequest.Router.Helpers

  location :pull_url

  attributes [:title, :body, :locked, :state]

  has_one :repository, link: :repo_url
  has_many :comments, link: :comments_url
  def pull_url(p, conn) do
    pull_url(conn, :show, p.id)
  end

  def repo_url(p, conn) do
    repository_url(conn, :show, p.repository_id)
  end

  def comments_url(r, conn) do
    pull_comment_url(conn, :index, r.id)
  end
end
