# Saga queue

## Active: foundation contract

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

## Queued: matrix concept stepping

Implement matrix multiplication in readable MLPL, exposing inputs, row/column,
products, partial sums, and result while independently asserting the output.

## Queued: linear-regression timeline

Implement bounded deterministic linear regression with prediction, residual,
loss, gradient, parameter, and trajectory observations.

## Queued: K-means phases

Implement bounded deterministic K-means assignment/update phases. Use the
lesson to decide how multiple named observations group into one logical frame.

## Future

After three lessons: review and hand off a reusable MLPL helper. Then add a
static recorded viewer, MLP forward/backward, PCA, attention, tiny LM, LoRA,
and Engram. Browser Explorer and native viewer work remain separate handoffs
after the protocol is proven.
