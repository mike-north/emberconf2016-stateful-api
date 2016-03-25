defmodule Pullrequest.PageController do
  use Pullrequest.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
