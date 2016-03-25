defmodule Pullrequest.Router do
  use Pullrequest.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "api", Pullrequest do
    pipe_through :api # Use the default browser stack
    resources "repositories", RepositoryController, only: [:show, :update]
    resources "organizations", OrganizationController, except: [:new, :edit, :destroy] do
      resources "repositories", RepositoryController, only: [:index, :create] do
        
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Pullrequest do
  #   pipe_through :api
  # end
end
