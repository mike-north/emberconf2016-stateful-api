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

client = Tentacat.Client.new(%{access_token: System.get_env("GH_TOKEN") || ""})

["emberjs", "ember-cli", "tildeio", "babel"]
|> Enum.each fn org_name -> 
    org_info = Tentacat.Organizations.find(org_name, client)
    project = Pullrequest.Repo.insert! %Pullrequest.Organization{
      name: org_info["name"],
      icon_url: org_info["avatar_url"]
    }
    Tentacat.Repositories.list_orgs(org_name, client)
    |> Enum.take_random(3)
    |> Enum.each fn repo_info ->
      repo = Pullrequest.Repo.insert! %Pullrequest.Repository{
        organization_id: project.id,
        name: repo_info["name"],
        description: repo_info["description"],
        homepage: repo_info["homepage"]
      }
      Tentacat.Pulls.list(org_name, repo_info["name"], client)
      |> Enum.take_random(5)
      |> Enum.each fn pull_info ->
        pull = Pullrequest.Repo.insert! %Pullrequest.Pull{
          repository_id: repo.id,
          title: pull_info["title"],
          body: pull_info["body"],
          locked: pull_info["locked"],
          state: pull_info["state"]
        }
      end
    end

  end



