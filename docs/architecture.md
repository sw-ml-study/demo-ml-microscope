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
  +---------+----------+
  |                    |
static/text host   later generic hosts
numeric evidence  browser / native extension
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

`demo-extensions` should eventually own an optional generic native viewer:
bounded frame ingestion/storage, cards/charts/tensor inspection, playback,
selection, and its Port/window/render lifecycle. It should reuse the existing
headless and parked-main architecture without learning ML algorithm names.

`sw-mlpl` remains the language and generic browser host. Proposed changes need
a minimal executable reproducer from this repo and interpreter/compiler/WASM
acceptance. Existing `emit_frame` is the starting point, not evidence that new
builtins are already required.

## Explicit non-boundaries

- Attention, PCA, K-means, LoRA, and Engram remain MLPL programs.
- The transformer implementation remains sw-MLPL's existing model machinery.
- Recorded playback does not imply live pause/resume.
- A native viewer does not replace browser/static consumers.
- Visualization does not replace numeric assertions or textual explanations.
