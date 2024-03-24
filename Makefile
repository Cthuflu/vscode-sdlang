#!/usr/bin/env make

MAKEFLAGS += --no-builtin-rules

BUILD := _build
BUILD.SYNTAX := $(BUILD)/syntaxes

VPATH = syntaxes

.PHONY: all

all: build

$(BUILD)/%/:
	mkdir -p $@

# Convert yaml to VSCode's desired json
$(BUILD.SYNTAX)/%.tmLanguage.json: %.tmLanguage.yaml | $(BUILD.SYNTAX)/
	npx js-yaml $< > $@

SYNTAX.SOURCE := $(wildcard syntaxes/*.tmLanguage.yaml)
SYNTAX.TARGET := $(patsubst %.yaml,$(BUILD.SYNTAX)/%.json,$(notdir $(SYNTAX.SOURCE)))

.PHONY: build

build: $(SYNTAX.TARGET)

.PHONY: package

package: build
	npx vsce package
