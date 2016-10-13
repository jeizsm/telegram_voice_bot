FROM elixir:1.3-slim
MAINTAINER Marat Safin <jeizsm@gmail.com>

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y --no-install-recommends git ffmpeg ca-certificates && apt-get autoremove

RUN useradd -ms /bin/bash app
USER app
RUN mkdir /home/app/app
WORKDIR /home/app/app

RUN mix local.hex --force && mix local.rebar --force
ADD mix.exs mix.exs
ADD mix.lock mix.lock
RUN mix deps.get
ARG MIX_ENV=prod
RUN mix deps.clean --unused --only=$MIX_ENV && mix deps.compile --include-children
ADD . .
RUN mix compile
RUN rm -rf /home/app/.hex

ENTRYPOINT ["mix"]
CMD ["phoenix.server"]
ENV PORT=80 MIX_ENV=$MIX_ENV TELEGRAM_TOKEN=token GCP_CREDENTIALS={}
