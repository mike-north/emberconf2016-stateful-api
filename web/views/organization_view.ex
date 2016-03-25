defmodule Pullrequest.OrganizationView do
  use Pullrequest.Web, :view
  use JaSerializer.PhoenixView # Or use in web/web.ex
  import Pullrequest.Router.Helpers

  attributes [:name, :icon_url]

  has_many :repositories, link: :org_repositories_url

  def org_repositories_url(organization, conn) do
    organization_repository_url(conn, :index, organization.id)
  end
end
