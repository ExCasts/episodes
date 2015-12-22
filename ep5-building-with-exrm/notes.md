## Initial Deployment

1. Add exrm dependency

        {:exrm, "~> 0.19"}

1. Install and compile dependencies

        mix do deps.get, compile

1. Show tasks

        mix help

1. Build prod release

        MIX_ENV=prod mix release

1. Go over generated file's highpoints and discuss

1. Deployment example

        mkdir -p /tmp/app
        cp rel/test/releases/0.0.1/test.tar.gz /tmp/
        cd /tmp/test
        tar -xf /tmp/test.tar.gz

1. Show all the things the app can do

        bin/test console
        > :application.get_key [:test, :vsn]
        > GenServer.call(:Server, :hello)
        bin/test start
        bin/test ping
        bin/test restart
        bin/test ping
        bin/test remote_console
        > :application.get_key [:test, :vsn]
        > GenServer.call(:Server, :hello)
        bin/test ping
        bin/test rpc application get_key "[test, vsn]."
        bin/test stop
        bin/test ping


## Hot upgrades/downgrades

1. Build version 0.0.2

        MIX_ENV=prod mix release

1. Deploy version 0.0.2

        mkdir -p /tmp/app/releases/0.0.2
        cp rel/test/releases/0.0.2/test.tar.gz /tmp/app/releases/0.0.2/
        cd /tmp/test
        bin/test rpc application get_key "[test, vsn]."
        bin/test upgrade "0.0.2"
        bin/test rpc application get_key "[test, vsn]."

1. Downgrade to version 0.0.1

        bin/test start
        bin/test ping
        bin/test rpc application get_key "[test, vsn]."
        bin/test upgrade "0.0.2"
        bin/test rpc application get_key "[test, vsn]."
        bin/test remote_console
        > GenServer.call(:Server, :hello)


## Fresh Install

1. Build version 0.0.3

        MIX_ENV=prod mix release

1. Deploy version 0.0.3

        rm -rf bin/test/*
        cp rel/test/releases/0.0.1/test.tar.gz /tmp/
        cd /tmp/test
        tar -xf /tmp/test.tar.gz
