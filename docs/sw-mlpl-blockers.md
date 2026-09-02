# sw-MLPL capability ledger

Status combines source inspection with native mlplunit and live loopback SSE
probes documented in `observation-contract.md`. No item is an authorized
upstream request yet.

## Supported

| Capability | Current evidence | Initial use |
|---|---|---|
| Numeric observation | Native tests prove disconnected identity for scalar through rank three; SSE proves ordered name/step/shape/value events | assembly primitive for literal lesson checkpoints |
| Numeric arrays and labeled dimensions | language and array contracts in `../sw-mlpl` | lesson state and shape explanations |
| Autograd/training | current evaluator/model APIs and demos | regression and later backward lessons |
| Attention inspection | `attention_weights` returns rank-2 or rank-3 maps | later attention lesson, not new Rust |
| Static visual evidence | SVG plots, heatmaps, scatter, curves, landscapes | lesson fallback and README assets |
| Browser/WASM and connect transport | current web evaluator and frame trace code | future generic host substrate |

## Awkward but apparently expressible

| Capability | Why awkward | Downstream experiment |
|---|---|---|
| Multiple observations per logical step | SSE preserves calls sharing a step, but there is no explicit group/phase envelope | same integer step with stable slash names |
| Semantic roles and explanations | tensor event is numeric; roles/notes lack a demonstrated typed envelope | naming convention plus independent lesson text |
| Recorded playback | SSE carries all frames, but browser `frame_trace` retains only the latest per generation | local bounded SSE recorder/static view |
| Shape-directed view selection | host can inspect shape but producer hint semantics are not frozen | infer defaults in downstream viewer contract |
| Large observation policy | no microscope-specific total frame/byte contract is established | tiny values; reject rather than silently sample |
| Gradient introspection | general autograd exists, but exact intermediate/parameter surfaces need probes | tiny explicit models and focused tests |

## Not yet demonstrated / candidate blockers

These are questions or confirmed host limitations, not authorized blockers:

1. The current browser frame store cannot retain multiple named tensors; can a
   generic bounded host change solve this without changing the evaluator?
2. Can strings/annotations and optional presentation roles share a generic
   ordered timeline without encoding metadata into numeric tensors or names?
3. Do interpreted, compiled, REPL/connect, and WASM paths expose equivalent
   frame semantics?
4. Which explicit per-event and per-run budgets should a browser recorder
   enforce, and how should visible eviction/error behavior work?
5. Which public APIs expose the gradients needed for an honest tiny-backprop
   lesson without reimplementing autograd?

A confirmed blocker must add a minimal `.mlpl` reproducer, configured tool
version/revision, expected signature and semantics, positive/negative/boundary
acceptance cases, affected lessons, and an explicit currently-unavailable
result. Until then, no `sw-mlpl` change is requested.
