# First command incase users forget to supply one
# cat self as help for simplicity
help:
	cat Makefile
.PHONY: help

gen:
	hof gen

build:
	go build -o cuetils ./cmd/cuetils

install:
	go install ./cmd/cuetils

.PHONY: test test.cli test.lib test.cue
test: test.cli test.lib test.cue
test.cli:
	hof test -s cli -t test
test.lib:
	hof test -s lib -t test
test.cue:
	hof test -s cue -t test

WORKFLOWS = default

.PHONY: workflow
workflows = $(addprefix workflow_, $(WORKFLOWS))
workflow: $(workflows)
$(workflows): workflow_%:
	@cue export --out yaml .github/workflows/$(subst workflow_,,$@).cue > .github/workflows/$(subst workflow_,,$@).yml

