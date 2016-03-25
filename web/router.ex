defmodule Pullrequest.Router do
  use Pullrequest.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "api", Pullrequest do
    pipe_through :api # Use the default browser stack
    resources "projects", ProjectController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Pullrequest do
  #   pipe_through :api
  # end
end
