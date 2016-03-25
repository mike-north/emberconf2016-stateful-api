defmodule Pullrequest.ProjectView do
  use Pullrequest.Web, :view
  use JaSerializer.PhoenixView # Or use in web/web.ex

  attributes [:name, :icon_url]
end
