# sw-MLPL capability ledger

Status here is based on source/documentation inspection during the foundation
step. It must be replaced or strengthened with executable probes in the next
step. No item is an authorized upstream request yet.

## Supported

| Capability | Current evidence | Initial use |
|---|---|---|
| Numeric observation | `emit_frame(name, step, x)` is documented as whole-tensor connect output and identity-returning | assembly primitive for MLPL helper |
| Numeric arrays and labeled dimensions | language and array contracts in `../sw-mlpl` | lesson state and shape explanations |
| Autograd/training | current evaluator/model APIs and demos | regression and later backward lessons |
| Attention inspection | `attention_weights` returns rank-2 or rank-3 maps | later attention lesson, not new Rust |
| Static visual evidence | SVG plots, heatmaps, scatter, curves, landscapes | lesson fallback and README assets |
| Browser/WASM and connect transport | current web evaluator and frame trace code | future generic host substrate |

## Awkward but apparently expressible

| Capability | Why awkward | Downstream experiment |
|---|---|---|
| Multiple observations per logical step | `emit_frame` exposes name and numeric step but no frozen group/phase contract | same step with stable slash names; test ordering |
| Semantic roles and explanations | tensor event is numeric; roles/notes lack a demonstrated typed envelope | naming convention plus independent lesson text |
| Recorded playback | current live board/frame trace is not yet a lesson-level retained timeline contract | generate bounded artifact/static view locally |
| Shape-directed view selection | host can inspect shape but producer hint semantics are not frozen | infer defaults in downstream viewer contract |
| Large observation policy | no microscope-specific total frame/byte contract is established | tiny values; reject rather than silently sample |
| Gradient introspection | general autograd exists, but exact intermediate/parameter surfaces need probes | tiny explicit models and focused tests |

## Not yet demonstrated / candidate blockers

These are questions, not confirmed blockers:

1. Can public connect/WASM consumers retain multiple named tensors in exact
   emission order with sufficient numeric fidelity and visible budget errors?
2. Can strings/annotations and optional presentation roles share a generic
   ordered timeline without encoding metadata into numeric tensors or names?
3. Do interpreted, compiled, REPL/connect, and WASM paths expose equivalent
   frame semantics?
4. Can a browser host provide bounded retained playback without changes to the
   evaluator, or is only host work required?
5. Which public APIs expose the gradients needed for an honest tiny-backprop
   lesson without reimplementing autograd?

A confirmed blocker must add a minimal `.mlpl` reproducer, configured tool
version/revision, expected signature and semantics, positive/negative/boundary
acceptance cases, affected lessons, and an explicit currently-unavailable
result. Until then, no `sw-mlpl` change is requested.
