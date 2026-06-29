# 變數定義
IMAGE_PREFIX := maxisme-ai-dev-sandbox
CLAUDE_NAME := $(IMAGE_PREFIX)-claude
CODEX_NAME := $(IMAGE_PREFIX)-codex
TAG := latest

.PHONY: help docker claude clean

all: help

help: ## help
	@echo "commands："
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

docker_claude: ## build claude
	cd claude && docker build -t $(CLAUDE_NAME):$(TAG) .

docker_codex: ## build codex
	cd codex && docker build -t $(CODEX_NAME):$(TAG) .

alias_claude: ## add cc alias to run claude
	@if ! grep -q "alias cc=" ~/.zshrc; then \
		echo "alias cc='docker run --rm -it -v \$$(pwd):/app -v \$$(pwd)/.git:/app/.git:ro -v /app/.claude  -v ~/.claude/settings.json:/root/.claude/settings.json -e GOPROXY=\"https://nexus.skyunion.net/repository/go-group,https://proxy.golang.org,direct\" -e GONOSUMDB=\"git.skyunion.net/*\" $(CLAUDE_NAME):$(TAG)'" >> ~/.zshrc; \
		echo "✅ 已成功加入 alias"; \
	else \
		echo "⚠️  alias cc 已經存在，跳過處理"; \
	fi

alias_codex: ## add cx alias to run codex
	@if ! grep -q "alias cx=" ~/.zshrc; then \
		echo "alias cx='docker run --rm -it --cap-drop ALL --security-opt no-new-privileges --read-only -v "\$$(pwd):/app:rw" -v "\$$(pwd)/.git:/app/.git:ro" -v ~/.codex:/root/.codex -v /root/.codex/packages -e GOPROXY=\"https://nexus.skyunion.net/repository/go-group,https://proxy.golang.org,direct\" -e GONOSUMDB=\"git.skyunion.net/*\" $(CODEX_NAME):$(TAG)'" >> ~/.zshrc; \
		echo "✅ 已成功加入 alias"; \
	else \
		echo "⚠️  alias cx 已經存在，跳過處理"; \
	fi

clean_claude: ## remove docker image
	docker rmi $(CLAUDE_NAME):$(TAG)

clean_codex: ## remove docker image
	docker rmi $(CODEX_NAME):$(TAG)