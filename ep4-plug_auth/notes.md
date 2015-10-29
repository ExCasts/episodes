## Disclaimer

This episode is about creating a custom plug for Phoenix, not API authentication. 
Authentication is simply a use case in which it can make sense to implement part
of it as a plug.  If you are interested in application authentication there are 
many [Elixir projects](https://github.com/h4cc/awesome-elixir#authentication) 
already solving this problem.

While we are implementing small component of an authentication token scheme, this 
episode does not include many of the features one would need to call it feature
complete.  For example: unique tokens per user with a TTL, facilities to expire a token,
facilities to generate an initial or new token after expiration, facilities to manage 
a user's account, etc.
