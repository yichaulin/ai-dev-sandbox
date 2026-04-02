# 變數定義
IMAGE_NAME := claude-code-dev-sandbox
TAG := latest

.PHONY: help build clean

all: help

help: ## help
	@echo "commands："
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

build: ## build docker
	cd claude && docker build -t $(IMAGE_NAME):$(TAG) .

run: ## run claude code image
	docker run --rm -it $(IMAGE_NAME):$(TAG) sh

alias:
	@if ! grep -q "alias cc=" ~/.zshrc; then \
		echo "alias cc='docker run --rm -it -v \$$(pwd):/app -v /app/.claude -v ~/.claude/settings.json:/root/.claude/settings.json claude-code-dev-sandbox:latest'" >> ~/.zshrc; \
		echo "✅ 已成功加入 alias"; \
	else \
		echo "⚠️  alias cc 已經存在，跳過處理"; \
	fi
clean: ## remove docker image
	docker rmi $(IMAGE_NAME):$(TAG)