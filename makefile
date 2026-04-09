# Variables
BUF_BIN := $(shell which buf)
PROTO_DIR := proto
GEN_DIR := codegen

.PHONY: all
all: format lint generate

## lint: Lint the protobuf files
.PHONY: lint
lint:
	@echo "?? Linting protos..."
	@$(BUF_BIN) lint

## format: Format the protobuf files
.PHONY: format
format:
	@echo "?? Formatting protos..."
	@$(BUF_BIN) format -w

## generate: Generate code from proto files
.PHONY: generate
generate: clean
	@echo "?? Generating code..."
	@$(BUF_BIN) generate
	@echo "? Code generated in $(GEN_DIR)"

## clean: Remove generated files
.PHONY: clean
clean:
	@echo "?? Cleaning generated files..."
	@rm -rf $(GEN_DIR)

.PHONY: all
all: format lint generate

## commit-pro: Interactive Conventional Commit with numeric selection
.PHONY: commit
commit: all
	@echo "$(BLUE)--- Conventional Commit Builder ---$(RESET)"
	@echo "Select the type of change:"
	@echo "  1) feat     (New feature)"
	@echo "  2) fix      (Bug fix)"
	@echo "  3) chore    (Maintenance/Build)"
	@echo "  4) docs     (Documentation)"
	@echo "  5) refactor (Code improvement)"
	@echo "  6) style    (Formatting/UI)"
	@read -p "Selection [1-6]: " TYPE_NUM; \
	case $$TYPE_NUM in \
		1) T="feat" ;; \
		2) T="fix" ;; \
		3) T="chore" ;; \
		4) T="docs" ;; \
		5) T="refactor" ;; \
		6) T="style" ;; \
		*) T="feat" ;; \
	esac; \
	read -p "Enter Scope (e.g., auth, user, api): " S; \
	read -p "Enter Title: " ST; \
	read -p "Enter Description: " D; \
	S=$${S:-proto}; ST=$${ST:-update definitions}; \
	if [ -z "$$(git status --porcelain)" ]; then \
		echo "$(YELLOW)? No changes to commit.$(RESET)"; \
	else \
		git add .; \
		git commit -m "$$T($$S): $$ST" -m "$$D"; \
		echo "$(GREEN)? Successfully committed: $$T($$S): $$ST$(RESET)"; \
	fi