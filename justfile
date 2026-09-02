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

# Run the first visible matrix microscope and check its SVG preview.
matrix:
    ./scripts/run-matrix-demo

# Validate the committed Rust/Yew matrix recording fixture.
matrix-fixture:
    ./scripts/check-matrix-recording

# Prove the live matrix SSE stream matches the committed recording.
matrix-recording:
    ./scripts/run-matrix-recording

# Run the complete precommit gate.
check:
    ./scripts/check
