FROM golang:1.26-bookworm

RUN apt-get update && apt-get install -y curl python3 bash-completion fzf

RUN curl -fsSL https://claude.ai/install.sh | bash

ENV PATH="/root/.local/bin:${PATH}"
ENV SHELL=/bin/bash

WORKDIR /app
ENTRYPOINT ["claude"]
