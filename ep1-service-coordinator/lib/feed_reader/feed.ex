defmodule FeedReader.Feed do

  defstruct pid: nil,
            uri: nil,
            length: nil,
            titles: []

  def get(from, uri) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(uri)
    {:ok, feed, _} = FeederEx.parse(body)
    send_length(from, feed)
    send_titles(from, feed)
  end

  defp send_length(from, feed) do
    send from, {:feed_length, self, length(feed.entries)}
  end

  defp send_titles(from, feed) do
    titles = Enum.map(feed.entries, &(&1.title))
    send from, {:feed_titles, self, titles}
  end

end
