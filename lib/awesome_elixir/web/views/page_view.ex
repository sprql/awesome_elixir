defmodule AwesomeElixir.Web.PageView do
  use AwesomeElixir.Web, :view

  def sections_for_repositories(repositories) do
    repositories
    |> Enum.uniq_by(&(&1.section_id))
    |> Enum.map(&(&1.section))
    |> Enum.sort_by(&(&1.name))
  end

  def repositories_for_section(repositories, section) do
    repositories
    |> Enum.filter(&(&1.section_id == section.id))
    |> Enum.sort_by(&(&1.name))
  end
end
