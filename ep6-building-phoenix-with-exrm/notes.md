## Initial Deployment

1. Add exrm dependency

        {:exrm, "~> 0.19"}

1. Install and compile dependencies

        mix do deps.get, compile

1. Build prod release

        MIX_ENV=prod mix phoenix.digest
        MIX_ENV=prod mix release

1. Deployment example

        mkdir -p /tmp/app
        cp rel/test/releases/0.0.1/hello.tar.gz /tmp/
        cd /tmp/test
        tar -xf /tmp/test.tar.gz

1. Show all the things the app can do

