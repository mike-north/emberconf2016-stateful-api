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
    |> Enum.take_random(15)
    |> Enum.each fn repo_info ->
      repo = Pullrequest.Repo.insert! %Pullrequest.Repository{
        organization_id: project.id,
        name: repo_info["name"],
        description: repo_info["description"],
        homepage: repo_info["homepage"]
      }
      Tentacat.Pulls.list(org_name, repo_info["name"], client)
      |> Enum.take_random(25)
      |> Enum.each fn pull_info ->
        pull = Pullrequest.Repo.insert! %Pullrequest.Pull{
          repository_id: repo.id,
          title: pull_info["title"],
          body: pull_info["body"],
          locked: pull_info["locked"],
          state: pull_info["state"]
        }
        Tentacat.Pulls.Comments.list(org_name, repo_info["name"], pull_info["number"], client)
        |> Enum.each fn comment_info ->
          comment = Pullrequest.Repo.insert! %Pullrequest.Comment{
            pull_id: pull.id,
            body: comment_info["body"],
            path: comment_info["path"],
            commit_id: comment_info["commit_id"],
            diff_hunk: comment_info["diff_hunk"]
          }
        end
      end
    end

  end



