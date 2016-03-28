defmodule Pullrequest.ErrorView do
  use Pullrequest.Web, :view

  
  def render("404.json", %{conn: conn} = assigns) do
    %{
      errors: [%{
        status: "404",
        title: "Not Found",
        detail: "#{assigns.conn.method} #{assigns.conn.request_path} could not be found"
      }]
    }
  end

  def render("404.json", _assigns) do
    %{
      errors: [%{
        status: "404",
        title: "Not Found",
        detail: "Not found"
      }]
    }
  end

  def render("500.json", %{reason: reason} = assigns) do
    str = case reason do
      %UndefinedFunctionError{} = x ->
        "Undefined function #{x.function} in module #{x.module}"
      %{message: m} = y ->
        m
      _ -> "General Server Error"
    end
    %{errors: [%{
      status: "500",
      title: "Server Error",
      detail: to_string(str)
      }]
    }
  end

  def render("500.json", _assigns) do
    %{errors: [%{
      status: "500",
      title: "Server Error",
      detail: "Server Error"
      }]
    }
  end

  def render("unauthenticated", assigns) do
    %{errors: [%{
      status: "401",
      title: "Unauthenticated",
      detail: assigns.message
      }]
    }
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end
end
