# Portunes
An Elixir Config Server inspired by Spring Boot's own config server


# Rationale
Many developers agree that a service and it's production configuration should remain in different repositories and be injected at runtime. The easiest way tends to be via ENV_VARS that the service will read when booting up. 

This is not a problem unless you intend to put the service inside a container, building and deploying an image. In this case you would set the env vars externally and the service would know to read them during runtime. But what happens when you want to change this config? Ideally you have this config in another repo, so it would automatically trigger a webhook or run a pipeline with every new comit. This is extra work in on itself, but also has a big problem: it is not possible to externally modify the env of a running container without restarting it (although ppl have devised [multiple workarounds](https://github.com/moby/moby/issues/8838). In many cases this means you have to rebuild the image because the environment is set during the build phase, which usually also means passing the whole pipeline again, which even if it takes just 10 mins means wasting 9:30 min more than necessary (and who are we kidding, 30+ min pipelines are all too common).

On the other hand elixir almost forces your services to be stateless, so having the configuration being updated while the service is running is way less dangerous than with statefull services (you should be carefull if using stateful processes ofc) so having a central repository of configuration that can be updated at any time is very convenient and relatively safe.

The question of the performance and the number of calls can be mitigated by employing another Elixir (well, Erlang) tool: the ETS tables. No need to add external dependencies such a redis cache when every Erlang virtual machine already ships with a cache that serves our neeeds.

By caching both client and server we can ensure that no time is wasted doing unnecesary HTTP calls or waiting for the server to read its file system (or worse, synchronously fetching commits from a Git config repo).

The last element of this config server/client pair is having a way for the server itself to push config updates, which can easily be achieved by using Phoenix Websockets.


# Architecture
![an image of portunes' architecture done in google drive's sheets by a artististically deaf dev](docs/images/architectural-summary.svg)


# PortunesCore

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `portunes_core` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:portunes_core, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/portunes_core](https://hexdocs.pm/portunes_core).


