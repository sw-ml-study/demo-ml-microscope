set shell := ["sh", "-cu"]

# Show available repository tasks.
default:
    @just --list

# Check canonical formatting and documentation for tracked MLPL source.
mlpl-style:
    ./scripts/check-mlpl-style

# Run native mlplunit tests; arguments select paths, tags, or filters.
tests *args:
    ./scripts/run-tests {{args}}

# Check public emit_frame error diagnostics.
emit-frame-errors:
    ./scripts/run-emit-frame-errors

# Probe live SSE frame ordering and payload fidelity.
emit-frame-sse:
    ./scripts/run-emit-frame-sse

# Run the complete precommit gate.
check:
    ./scripts/check
