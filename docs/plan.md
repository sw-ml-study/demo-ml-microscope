# ML microscope delivery plan

## Outcome

Build executable sw-MLPL lessons whose own semantically named intermediate
values form a recorded, inspectable timeline. A learner can read and modify the
MLPL algorithm, rerun it, and review how its state changes without a bespoke
Rust implementation of each ML concept.

MLPL owns concepts and application semantics. Hosts render generic observed
values and manage playback or interaction. Work moves upstream only after a
downstream executable probe proves that current public behavior blocks a
general contract.

## Evidence and current constraints

- `emit_frame(name, step, x)` streams a whole numeric tensor through the
  connect-mode metric sink, returns `x`, and is a no-op when disconnected.
- sw-MLPL already provides arrays, named axes, autograd, model helpers,
  attention extraction, traces, SVG plots, browser/WASM execution, and SSE.
- Current frame events carry a name, numeric step, shape, and numeric values;
  they do not yet constitute a versioned multi-observation lesson protocol.
- `demo-extensions` already proves arrays, records, handles, a parked-main
  Port architecture, and headless/native rendering tests.
- `demo-mlpl-libraries` already proves revision-pinned, hash-verified source
  vendoring for reusable MLPL modules.
- Recorded rewind is host-side browsing. Reverse evaluation and synchronous
  browser checkpoints are deliberately outside the first milestone.

## Architecture rule

```text
demo-ml-microscope (.mlpl concepts and lessons)
          |
          +-- repeated domain-neutral helpers --> demo-mlpl-libraries
          |
          +-- generic native UI requirement ----> demo-extensions (Rust)
          |
          `-- proven language-wide blocker ------> sw-mlpl
```

Rust may define generic observation envelopes, bounded retention, tensor
inspectors, renderers, timelines, transports, and playback controls. It must
not define `TransformerVisualizer`, `PcaVisualizer`, `KMeansVisualizer`, or
other algorithm-specific semantics.

## Saga 1: foundation and measured contract

1. Establish Agentrail instructions, licensing, project README, repository
   checks, architecture, cross-repository ownership, and an evidence-backed
   capability ledger.
2. Probe `emit_frame` across the supported interpreter/connect path and freeze
   the smallest recorded-observation contract: names, steps, grouping, numeric
   shapes, fidelity, ordering, budgets, errors, and disconnected behavior.
3. Add root mlplunit/tool selection/style infrastructure and one tiny fixture
   proving the current public API without adding Rust or changing siblings.

Exit: `just check` passes from a clean checkout and documentation distinguishes
supported, awkward, and blocked behavior using executable evidence.

## Saga 2: pure-MLPL proof of concept

1. Implement matrix multiplication as concept stepping: inputs, selected row
   and column, products, partial sums, and completed output.
2. Implement two-parameter linear regression/gradient descent with data,
   predictions, residuals, loss, gradients, parameters, and trajectory frames.
3. Implement K-means with explicit initial, assignment, and centroid-update
   phases, forcing a clean convention for multiple observations per step.
4. Build a deterministic recorded-timeline artifact and a dependency-free
   textual/static viewer sufficient for acceptance; browser and native hosts
   remain optional consumers of the same data.

Exit: three unrelated lessons use the same small observation helpers; retained
state is bounded; numeric/text evidence exists independently of visuals.

## Saga 3: reusable MLPL observation library

1. Review the helpers after three consumers and freeze only domain-neutral
   functions such as observe-at, metric, note, and bounded summaries.
2. Write a producer contract and a separately actionable extraction handoff for
   `demo-mlpl-libraries`, including prefixes, tests, catalog metadata, install
   provenance, and migration order.
3. After that sibling change is independently delivered, vendor the immutable
   library revision here and prove hash-checked consumption. Do not couple this
   repo to an adjacent working tree at runtime.

Exit: this repository consumes a pinned library; lesson semantics remain local.

## Saga 4: deeper ML learning path

Add capability-supported lessons in prerequisite order: vector/shape
inspection, MLP forward pass, explicit backward gradients, PCA, attention,
tiny language model, LoRA, and Engram. Each lesson names shapes, tolerance,
claim boundaries, and the exact supported/awkward/blocking capabilities it
exercises. Transformer work reuses sw-MLPL's model implementation; it does not
implement a second transformer in Rust.

Exit: the learning path reaches a small real model while remaining readable,
bounded, deterministic, and executable as MLPL.

## Saga 5: generic hosts after protocol proof

1. Specify a versioned, renderer-neutral observation/timeline interchange from
   measured artifacts, including budgets and malformed-input behavior.
2. Hand off a full-featured generic Rust/Yew WASM microscope to
   `demo-extensions`. It consumes ordered SSE frames, owns bounded browser
   retention and playback, and keeps its parser/reducer headlessly testable.
3. Keep the existing native graphics path as an optional second renderer for
   desktop/3-D views, sharing the same observation contract. Request `sw-mlpl`
   changes only where its server or protocol demonstrably blocks the Yew host;
   do not add a duplicate core Explorer speculatively.
4. Add side-by-side execution comparison only after stable observation names
   and retention policies are proven.

Exit: the Yew browser and optional native hosts visualize the same MLPL-authored data
without knowing which algorithm produced it.

## Cross-cutting gates

- Every executable behavior starts with native mlplunit coverage and focused
  probes; `just check` is the full precommit gate.
- Every `.mlpl` file has a module comment, every user function has a first-body
  docstring, and canonical formatting is checked before commit and push.
- Lessons are deterministic and bounded; large values fail visibly until an
  explicit full/sample/summary policy is specified.
- Documentation, catalog, capability ledger, static fallback, and acceptance
  evidence change with the behavior they describe.
- Sibling repositories remain read-only. Their work is documented as a
  handoff, not simulated through edits or undocumented checkout dependencies.

## Non-goals

- Reverse interpreter execution in the initial implementation.
- A dashboard-layout DSL before real lessons require one.
- Silent sampling or downsampling.
- A special-purpose GPT, attention, PCA, K-means, or optimizer renderer.
- A new package mechanism or duplicate MLPL library implementation here.
- Modifying any sibling repository from this saga.
