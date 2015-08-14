defmodule FeedReader do

  alias FeedReader.Feed

  @feed_uris [
    "http://rss.cnn.com/rss/cnn_topstories.rss",
    "http://stackoverflow.com/feeds"
  ]

  def read do
    feeds = Enum.map(@feed_uris, fn(uri) ->
              pid = spawn(Feed, :get, [self, uri])
              {pid, %Feed{pid: pid, uri: uri}}
            end)
            |> Enum.into(%{})

    listen(feeds)
  end

  defp listen(feeds) do
    receive do
      {:feed_length, from, length} ->
        feeds = update_feed(feeds, from, {:length, length})

        if finished?(feeds) do
          present_results(feeds)
        else
          listen(feeds)
        end
      {:feed_titles, from, titles} ->
        feeds = update_feed(feeds, from, {:titles, titles})

        if finished?(feeds) do
          present_results(feeds)
        else
          listen(feeds)
        end
    end
  end

  defp finished?(feeds) do
    Enum.all?(feeds, fn({_uri, feed}) ->
      feed.length != nil &&
        !Enum.empty?(feed.titles)
    end)
  end

  defp present_results(feeds) do
    IO.puts nil

    Enum.each(feeds, fn({pid, feed}) ->
      IO.puts "*** #{feed.uri}"
      IO.puts "  Length: #{feed.length}"
      IO.puts "  Titles: "
      Enum.each(feed.titles, fn(title) ->
        IO.puts "    #{title}"
      end)
      IO.puts nil
    end)
  end

  defp update_feed(feeds, from, {:length, length}) do
    feed = feeds[from]
    feed = %{feed | length: length}
    Map.put(feeds, from, feed)
  end

  defp update_feed(feeds, from, {:titles, titles}) do
    feed = feeds[from]
    feed = %{feed | titles: titles}
    Map.put(feeds, from, feed)
  end

end
