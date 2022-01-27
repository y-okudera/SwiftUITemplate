.PHONY: help
help: ## Show this usage
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: xcode
xcode: ## Select latest version of Xcode
	sudo xcode-select --switch /Applications/Xcode.app/

.PHONY: bootstrap
bootstrap: ## Install tools
	make clean
	make build-cli-tools
	make format-configuration

.PHONY: project
project: ## Generate project
	make xcodegen

.PHONY: xcodegen
xcodegen: ## Generate Xcode project and workspace
	swift run -c release --package-path ./Tools xcodegen

.PHONY: swiftgen
swiftgen: ## Generate resources swift files.
	swift run -c release --package-path ./Tools swiftgen

.PHONY: open
open: ## Open Xcode workspace
	open ./App.xcodeproj

.PHONY: clean
clean: ## Clean generated files
	rm -rf ./**/Generated/*
	rm -rf ~/Library/Developer/Xcode/DerivedData/
	rm -rf Pods
	rm -rf Carthage
	rm -rf ./Tools/**/.build/*

.PHONY: format-configuration
format-configuration: ## Create default .swift-format file if not exists.
    ifneq ("$(wildcard .swift-format)","")
		echo Exists .swift-format;
    else
		swift run -c release --package-path ./Tools swift-format --mode dump-configuration > .swift-format;
    endif

.PHONY: lint
lint: ## Linting Swift code
	swift run -c release --package-path ./Tools swift-format -r ./PCSwiftUI -m lint

.PHONY: format
format: ## Reformatting Swift code
	swift run -c release --package-path ./Tools swift-format -r ./PCSwiftUI -i

.PHONY: build-cli-tools
build-cli-tools: # Build CLI tools managed by SwiftPM
	swift build -c release --package-path ./Tools --product license-plist
	swift build -c release --package-path ./Tools --product swiftgen
	swift build -c release --package-path ./Tools --product swift-format
	swift build -c release --package-path ./Tools --product xcodegen
