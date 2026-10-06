.DEFAULT_GOAL := install

install:
	./install.sh

.PHONY: lint
lint: lint-ansible lint-yaml fmt-yaml

.PHONY: lint-ansible
lint-ansible:
	@echo "Running ansible-lint..."
	@docker compose run -q --rm ansible-lint ansible-lint

.PHONY: lint-yaml
lint-yaml:
	@echo "Running yamllint..."
	@docker compose run -q --rm yamllint yamllint --strict .

.PHONY: fmt-yaml
fmt-yaml:
	@echo "Running yamlfmt..."
	@docker compose run -q --rm yamlfmt -lint .

.PHONY: fix
fix: lint-ansible-fix

.PHONY: lint-ansible-fix
lint-ansible-fix:
	@echo "Running ansible-lint..."
	@docker compose run -q --rm ansible-lint ansible-lint --fix
