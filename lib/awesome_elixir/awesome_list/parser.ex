defmodule AwesomeElixir.AwesomeList.Parser do
  defmodule Entity do
    defstruct url: nil, name: nil, section: {}
  end

  def parse(list) do
    {_, result} = Enum.reduce(list, {nil, []}, &parse_line/2)
    Enum.reverse(result)
  end

  defp parse_line(line, {current_section, result} = state) do
    cond do
      String.match?(line, ~r/^##\s*\w+/) ->
        [subsection] = Regex.run(~r/^##\s*(.+)$/, line, capture: :all_but_first)
        {subsection, result}

      String.match?(line, ~r/^\*\w+/) ->
        [subsection_description] = Regex.run(~r/^\*(.+)\*$/, line, capture: :all_but_first)
        {{current_section, subsection_description}, result}

      String.match?(line, ~r/^\*\s+\[\w+/) ->
        [name, url] = Regex.run(~r/^\*\s+\[(.+?)\]\((.+?)\)/, line, capture: :all_but_first)
        {current_section, [%Entity{url: url, name: name, section: current_section} | result]}

      true -> state
    end
  end
end
