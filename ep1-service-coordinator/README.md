# Service Coordinator (Feed Reader)

### Refactor #read function to be public API for the #handle_call(:read) function

Console:

      {:ok, feed_reader} = FeedReader.start_link([])
      FeedReader.read(feed_reader)

### Refactor implement generic #handle_info function to display messages arriving

Console:

      {:ok, feed_reader} = FeedReader.start_link([])
      FeedReader.read(feed_reader)

### Refactor refactor listen function to separate #handle_info functions

Console:

      {:ok, feed_reader} = FeedReader.start_link([])
      FeedReader.read(feed_reader)
      Process.alive?(feed_reader)
