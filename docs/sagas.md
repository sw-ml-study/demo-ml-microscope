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

## Completed locally and in sibling: Yew interactive viewer handoff

The shared schema, hash-pinned fixture index, two consumer recordings, pure
model boundaries, reducer semantics, generic views, accessibility behavior,
native/browser acceptance cases, and build/run/deploy contract are frozen in
`docs/yew-viewer-handoff.md`.

The independently authorized `../demo-extensions` agent delivered the offline
Rust/Yew app at commits `2ef0e33` and `3ecd025`, including its Rust checks and
Agentrail closeout. Live browser-to-server execution remains a later layer.

## Completed: K-means phases

KM01 implements bounded deterministic K-means assignment/update phases. Five
frames and fourteen observations establish grouping by numeric step plus
slash-separated semantic prefix, with stable call order and no new protocol
field or algorithm-specific renderer.

## Future

Review the three consumers and hand off a reusable MLPL observation helper.
The `demo-extensions` agent should first vendor KM01 into its generic viewer.
Then add MLP forward/backward, PCA, attention, tiny LM, LoRA, and Engram.
Optional native graphics remain a separate renderer handoff.
