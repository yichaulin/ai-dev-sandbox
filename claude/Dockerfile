FROM golang:1.26-bookworm

RUN apt-get update && apt-get install -y curl python3 bash-completion fzf

RUN curl -fsSL https://claude.ai/install.sh | bash

RUN mkdir -p /root/.claude

ENV TERM=xterm-256color
ENV COLORTERM=truecolor

ENV PATH="/root/.local/bin:${PATH}"
ENV SHELL=/bin/bash
ENV CLAUDE_CONFIG_DIR=/root/.claude


WORKDIR /app

ADD ./settings.local.json /app/.claude/settings.local.json
ADD ./claude.json /root/.claude/.claude.json

CMD ["claude"]
