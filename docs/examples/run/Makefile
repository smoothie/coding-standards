EXEC_PHP=/usr/bin/php
PATH_QA_BIN=../../../smoothie-coding-standards/vendor/bin/
PATH_QA_CONFIG=../../../smoothie-coding-standards/

.PHONY: help
help: ## Show this help.
	@echo "Available targets:"
	@echo "=================="
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

check-acceptance: ## Run acceptance test suite
	XDEBUG_TRIGGER=PHPSTROM ${PATH_QA_BIN}phpunit --configuration="phpunit.xml.dist" --testsuite="Acceptance"

check-integration: ## Run integration test suite
	XDEBUG_TRIGGER=PHPSTROM ${PATH_QA_BIN}phpunit --configuration="phpunit.xml.dist" --testsuite="Integration"

check-unit: ## Run unit test suite
	XDEBUG_TRIGGER=PHPSTROM ${PATH_QA_BIN}phpunit --configuration="phpunit.xml.dist" --testsuite="Unit"

check-quality: check-cs check-types check-layers ## Assure some kind of a quality

check-layers: ## Ensure application adheres to layers
	${EXEC_PHP} ${PATH_QA_BIN}deptrac analyse --config-file=depfile.yaml --report-uncovered --fail-on-uncovered --no-progress --no-interaction

check-cs: ## Ensure application adheres to code style
	${EXEC_PHP} ${PATH_QA_BIN}php-cs-fixer check --config=${PATH_QA_CONFIG}.php-cs-fixer.dist.php --no-interaction ./src/ ./config/

check-types: ## Ensure static code analyzer is happy
	${EXEC_PHP} ${PATH_QA_BIN}psalm --config=psalm.xml.dist --no-progress --output-format=console

fix-cs: ## Fix code style
	${EXEC_PHP} ${PATH_QA_BIN}php-cs-fixer fix --config=${PATH_QA_CONFIG}.php-cs-fixer.dist.php --no-interaction ./src/ ./config

fix-types: ## Try to fix broken code analyzer
	${EXEC_PHP} ${PATH_QA_BIN}psalm --config=psalm.xml.dist --no-progress --alter
