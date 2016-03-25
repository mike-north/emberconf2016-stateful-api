# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pullrequest.Repo.insert!(%Pullrequest.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

["emberjs", "ember-cli", "tildeio"]
|> Enum.each fn org_name -> 
    org_info = Tentacat.Organizations.find(org_name)
    project = Pullrequest.Repo.insert! %Pullrequest.Organization{
      name: org_info["name"],
      icon_url: org_info["avatar_url"]
    }
    Tentacat.Repositories.list_orgs(org_name)
    |> Enum.each fn repo_info ->
      Pullrequest.Repo.insert! %Pullrequest.Repository{
        organization_id: project.id,
        name: repo_info["name"],
        description: repo_info["description"],
        homepage: repo_info["homepage"]
      }
    end

  end



