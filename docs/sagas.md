# Saga queue

## Completed: foundation contract

Install Agentrail process rules; match peer copyright and MIT license; create
the README, architecture, plan, ownership handoffs, capability ledger, and
documentation-only `just check` gate.

Acceptance: generated instructions are current, peer license files compare
byte-for-byte, local documentation links resolve, the local MLPL/documentation
gate passes, and no sibling worktree is modified.

## Completed: measured emit-frame contract

Add native mlplunit/tool-selection infrastructure and probe current
`emit_frame` behavior: identity return, disconnected no-op, accepted numeric
shapes, name/step behavior, event ordering, and connect-path payload. Freeze a
small recorded-observation contract from measured evidence.

Accepted: four native mlplunit identity/rank/boundary tests, two public error
fixtures, and a live loopback SSE probe now run under `just check`. The measured
contract is in `docs/observation-contract.md`.

## Completed: matrix concept stepping

Implement matrix multiplication in readable MLPL, exposing inputs, row/column,
products, partial sums, and result while independently asserting the output.

Accepted: MM01 emits eight literal observations over five steps, derives the
exact 2-by-2 result, checks native `matmul` parity, generates a freshness-checked
SVG, and matches the committed budgeted Yew fixture over live SSE.

## Completed: linear-regression timeline

Implement bounded deterministic linear regression with prediction, residual,
loss, gradient, parameter, and trajectory observations.

Accepted: LR01 performs eight explicit analytic-gradient updates, retains five
checkpoints with 32 observations, reduces MSE from 21 below 0.0004, generates a
freshness-checked SVG, and matches its bounded Yew fixture over live SSE.

## Completed locally / queued in sibling: Yew interactive viewer handoff

The shared schema, hash-pinned fixture index, two consumer recordings, pure
model boundaries, reducer semantics, generic views, accessibility behavior,
native/browser acceptance cases, and build/run/deploy contract are frozen in
`docs/yew-viewer-handoff.md`.

Next external action: an independently authorized `../demo-extensions` agent
implements the Rust/Yew app and runs `sw-checklist` there. This repository
cannot claim interactive playback until that sibling work is delivered.

## Queued after interactive viewer handoff: K-means phases

Implement bounded deterministic K-means assignment/update phases. Use the
lesson to decide how multiple named observations group into one logical frame.

## Future

After the Yew sibling handoff and third lesson: review and hand off a reusable
MLPL helper. Then add MLP forward/backward, PCA, attention, tiny LM, LoRA, and
Engram. Optional native graphics remain a separate renderer handoff.
