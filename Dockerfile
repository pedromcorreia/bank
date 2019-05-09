FROM elixir:alpine

RUN apk update && apk add inotify-tools postgresql-dev \
    && apk add --no-cache build-base

RUN mkdir -p /umbrella
COPY . /umbrella
WORKDIR /umbrella

RUN mix local.hex --force && mix local.rebar --force \
    && mix deps.get && mix deps.compile

ENV MIX_ENV dev

EXPOSE 6000

CMD mix setup_db && \
    iex -S mix phx.server
