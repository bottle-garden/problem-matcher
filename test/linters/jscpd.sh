#!/bin/sh -e

. test/lib/setup/linter.sh

# TODO: Turn down `min-tokens` and refactor as you go
run_jscpd() {
    jscpd \
        --ignore '.venv/**' \
        --min-lines 1 --min-tokens 40 . |
        strip-ansi
}

# Using a pipe means the exit value of the first command will be ignored,
# allowing `obelist` to determine which severity level should result in an
# error
run_jscpd |
    obelist parse --quiet --console --write "${lint_out}" \
        --error-on="notice" --parser "jscpd" --format "txt" -
