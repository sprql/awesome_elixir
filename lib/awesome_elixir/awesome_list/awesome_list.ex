defmodule AwesomeElixir.AwesomeList do
  @moduledoc """
  The boundary for the AwesomeList system.
  """

  import Ecto.{Query, Changeset}, warn: false

  alias AwesomeElixir.Repo
  alias AwesomeElixir.AwesomeList.{Section, Repository}

  @doc """
  Returns the list of repositories with preloaded sections filtered by stars.

  ## Examples

      iex> list_repositories_with_stars()
      [%Repository{}, ...]

  """
  def list_repositories_with_stars(min_stars \\ 0) do
    query = from r in Repository,
            where: r.stars >= ^min_stars

    query
    |> Repo.all
    |> Repo.preload(:section)
  end

  @doc """
  Returns the list of sections.

  ## Examples

      iex> list_sections()
      [%Section{}, ...]

  """
  def list_sections do
    Repo.all(Section)
  end

  @doc """
  Gets a single section.

  Raises `Ecto.NoResultsError` if the Section does not exist.

  ## Examples

      iex> get_section!(123)
      %Section{}

      iex> get_section!(456)
      ** (Ecto.NoResultsError)

  """
  def get_section!(id), do: Repo.get!(Section, id)


  @doc """
  Creates or updates a section.

  ## Examples

      iex> create_or_update_section(%{field: value})
      {:ok, %Section{}}

      iex> create_or_update_section(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_or_update_section(attrs \\ %{}) do
    changeset = section_changeset(%Section{}, attrs)
    Repo.insert(changeset, on_conflict: :replace_all, conflict_target: :name)
  end

  @doc """
  Creates a section.

  ## Examples

      iex> create_section(%{field: value})
      {:ok, %Section{}}

      iex> create_section(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_section(attrs \\ %{}) do
    %Section{}
    |> section_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a section.

  ## Examples

      iex> update_section(section, %{field: new_value})
      {:ok, %Section{}}

      iex> update_section(section, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_section(%Section{} = section, attrs) do
    section
    |> section_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Section.

  ## Examples

      iex> delete_section(section)
      {:ok, %Section{}}

      iex> delete_section(section)
      {:error, %Ecto.Changeset{}}

  """
  def delete_section(%Section{} = section) do
    Repo.delete(section)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking section changes.

  ## Examples

      iex> change_section(section)
      %Ecto.Changeset{source: %Section{}}

  """
  def change_section(%Section{} = section) do
    section_changeset(section, %{})
  end

  defp section_changeset(%Section{} = section, attrs) do
    section
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end

  @doc """
  Returns the list of repositories.

  ## Examples

      iex> list_repositories()
      [%Repository{}, ...]

  """
  def list_repositories do
    Repo.all(Repository)
  end

  @doc """
  Gets a single repository.

  Raises `Ecto.NoResultsError` if the Repository does not exist.

  ## Examples

      iex> get_repository!(123)
      %Repository{}

      iex> get_repository!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repository!(id), do: Repo.get!(Repository, id)

  def get_repository_by_name(name) do
    Repo.get_by(Repository, name: name)
  end

  @doc """
  Creates or updates a repository.

  ## Examples

      iex> create_or_update_repository(%{field: value})
      {:ok, %Section{}}

      iex> create_or_update_repository(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_or_update_repository(attrs \\ %{}) do
    changeset = repository_changeset(%Repository{}, attrs)
    Repo.insert(changeset, on_conflict: :replace_all, conflict_target: :name)
  end

  @doc """
  Creates a repository.

  ## Examples

      iex> create_repository(%{field: value})
      {:ok, %Repository{}}

      iex> create_repository(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repository(attrs \\ %{}) do
    %Repository{}
    |> repository_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a repository.

  ## Examples

      iex> update_repository(repository, %{field: new_value})
      {:ok, %Repository{}}

      iex> update_repository(repository, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repository(%Repository{} = repository, attrs) do
    repository
    |> repository_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Repository.

  ## Examples

      iex> delete_repository(repository)
      {:ok, %Repository{}}

      iex> delete_repository(repository)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repository(%Repository{} = repository) do
    Repo.delete(repository)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repository changes.

  ## Examples

      iex> change_repository(repository)
      %Ecto.Changeset{source: %Repository{}}

  """
  def change_repository(%Repository{} = repository) do
    repository_changeset(repository, %{})
  end

  defp repository_changeset(%Repository{} = repository, attrs) do
    repository
    |> cast(attrs, [:section_id, :url, :name, :description, :stars, :last_updated_at])
    |> validate_required([:section_id, :url, :name, :description])
  end
end
