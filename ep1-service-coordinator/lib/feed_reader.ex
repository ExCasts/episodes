defmodule FeedReader do

  use GenServer

  alias FeedReader.Feed

  @feed_uris [
    "http://rss.cnn.com/rss/cnn_topstories.rss",
    "http://stackoverflow.com/feeds"
  ]

  def start_link(args, opts \\ []) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  def init(args) do
    {:ok, %{feeds: %{}, finished: false}}
  end

  def read(feed_reader) do
    GenServer.call(feed_reader, :read, 10_000)
  end

  def handle_call(:read, from, state) do
    feeds = Enum.map(@feed_uris, fn(uri) ->
              pid = spawn(Feed, :get, [self, uri])
              {pid, %Feed{pid: pid, uri: uri}}
            end)
            |> Enum.into(%{})

    {:reply, :ok, %{state | feeds: feeds}}
  end

  def handle_info({:feed_length, from, length}, state) do
    %{feeds: feeds} = state

    feeds = update_feed(feeds, from, {:length, length})

    if finished = finished?(feeds), do: present_results(feeds)

    {:noreply, %{state | feeds: feeds, finished: finished}}
  end

  def handle_info({:feed_titles, from, titles}, state) do
    %{feeds: feeds} = state

    feeds = update_feed(feeds, from, {:titles, titles})

    if finished = finished?(feeds), do: present_results(feeds)

    {:noreply, %{state | feeds: feeds, finished: finished}}
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
