defmodule Pullrequest.CommentView do
  use Pullrequest.Web, :view
  use JaSerializer.PhoenixView
  import Pullrequest.Router.Helpers

  location :comment_url

  attributes [:body, :diff_hunk, :path, :commit_id]

  has_one :pull, link: :pull_url
  def pull_url(c, conn) do
    pull_url(conn, :show, c.pull_id)
  end

  def comment_url(p, conn) do
    comment_url(conn, :show, p.id)
  end

end
