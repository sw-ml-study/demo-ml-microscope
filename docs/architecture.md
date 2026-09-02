# Architecture

## Governing principle

MLPL owns concepts and application semantics. Hosts render observations and
manage interaction.

The microscope is not a second ML runtime. A lesson computes real intermediate
values in sw-MLPL and labels selected values for inspection. The first host
retains the emitted states and lets a learner browse them after execution.
Previous/next/play therefore changes the selected retained frame; it does not
rewind, suspend, or replay the evaluator.

## Layering

```text
MLPL lesson
  algorithm + explicit educational checkpoints
            |
small MLPL observation facade
  name + numeric step + value, returning value unchanged
            |
current emit_frame assembly primitive
            |
renderer-neutral recorded observations
            |
  +---------+-------------------+
  |                             |
static/text host       preferred Yew/WASM host
numeric evidence       optional native graphics host
```

The observation API should remain tiny until three distinct lessons agree on
it. Candidate operations are `observe_at`, `metric`, and `note`; these names are
not yet a public promise. Slash-separated stable names such as
`forward/linear1/pre` may provide grouping before structured metadata is
justified.

## Shape-directed presentation

The producer supplies semantics, shape, and optional hints. A generic host can
choose defaults: scalar card, vector line/bar, `[n,2]` scatter, rank-2 heatmap,
rank-3 slice/head selector, and same-shaped diverging gradient heatmap. A hint
may override presentation but cannot change the authoritative numeric value.
Large values must be rejected with a visible budget error until explicit
full/sample/summary policy exists; hosts must not silently downsample.

## Delivery boundary

This repository implements `.mlpl` lessons, tests, fixtures, observation
naming, textual/static evidence, and protocol-driving artifacts. It may carry
an experimental MLPL helper while its API is being proven.

`demo-mlpl-libraries` should eventually own only proven domain-neutral MLPL
helpers. Installation must use its immutable revision and hash lock rather than
an adjacent checkout at runtime.

`demo-extensions` should own the preferred full-featured Rust/Yew WASM viewer:
bounded SSE ingestion/storage, cards/charts/tensor inspection, source and
explanation panels, playback, selection, and accessible browser interaction.
Its Rust model/reducer and protocol parser must remain headlessly testable. The
existing native graphics support remains an optional second renderer for 3-D
or desktop use; it may reuse the established Port/window lifecycle without
learning ML algorithm names.

`sw-mlpl` remains the language and generic browser host. Proposed changes need
a minimal executable reproducer from this repo and interpreter/compiler/WASM
acceptance. Existing `emit_frame` is the starting point, not evidence that new
builtins are already required.

The exact version-zero behavior lessons may rely on is frozen in the
[recorded observation contract](observation-contract.md).

## Explicit non-boundaries

- Attention, PCA, K-means, LoRA, and Engram remain MLPL programs.
- The transformer implementation remains sw-MLPL's existing model machinery.
- Recorded playback does not imply live pause/resume.
- The Yew/WASM viewer does not replace static/numeric acceptance evidence, and
  an optional native viewer does not fork the observation semantics.
- Visualization does not replace numeric assertions or textual explanations.
