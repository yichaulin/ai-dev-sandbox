FROM golang:1.26-bookworm

RUN apt-get update && apt-get install -y curl bash-completion fzf

RUN curl -fsSL https://chatgpt.com/codex/install.sh | sh
RUN mkdir -p /root/.codex

ENV TERM=xterm-256color
ENV COLORTERM=truecolor

ENV PATH="/root/.local/bin:${PATH}"
ENV SHELL=/bin/bash

WORKDIR /app

COPY ./config.json /root/.codex/config.json

CMD ["codex"]