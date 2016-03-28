defmodule Pullrequest.Router do
  use Pullrequest.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.Deserializer
  end

  scope "api", Pullrequest do
    pipe_through :api 
    resources "pulls", PullController, only: [:index]
    resources "repositories", RepositoryController, only: [:show, :update] do
      resources "pulls", PullController, only: [:index]
    end
    resources "comments", CommentController, only: [:show, :update, :destroy, :create]
    resources "pulls", PullController, only: [:show, :update] do
      resources "comments", CommentController, only: [:index, :create]
    end
    resources "organizations", OrganizationController, only: [:index, :show] do
      resources "repositories", RepositoryController, only: [:index]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Pullrequest do
  #   pipe_through :api
  # end
end
