## Initial Build & Deployment

1. Add exrm dependency

        {:exrm, "~> 1.0"}

1. Install and compile dependencies

        mix do deps.get, compile

1. Build prod release

        brunch build --production
        MIX_ENV=prod mix phoenix.digest
        MIX_ENV=prod mix compile 
        MIX_ENV=prod mix release

1. Deploy

        mkdir -p /tmp/app
        cp rel/test/releases/0.0.1/hello.tar.gz /tmp/
        cd /tmp/test
        tar -xf /tmp/test.tar.gz

## Hot Upgrade

        mkdir /tmp/app/releases/0.0.2
        cp rel/test/releases/0.0.2/hello.tar.gz /tmp/app/releases/0.0.2/.
        /tmp/app/bin/hello start
        /tmp/app/bin/hello upgrade "0.0.2"
