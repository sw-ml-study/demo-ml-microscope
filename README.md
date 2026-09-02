# demo-ml-microscope

Executable sw-MLPL lessons that expose semantically named intermediate values
as a recorded timeline. The goal is an ML microscope: read the algorithm in
MLPL, change it, run it, and inspect how arrays, parameters, gradients, and
metrics evolve without replacing the lesson with a bespoke Rust simulator.

The project starts from current public sw-MLPL behavior. In particular,
`emit_frame(name, step, value)` already streams a whole numeric tensor and
returns that value unchanged. The first implementation milestone will test how
far a small MLPL facade over that primitive can go before requesting any core
or native work.

## Ownership boundary

- This repository owns ML concepts, lesson sequencing, observation names,
  explanations, numeric evidence, and `.mlpl` applications.
- [`demo-mlpl-libraries`](../demo-mlpl-libraries) is the future home for a
  domain-neutral observation helper only after three unrelated lessons prove
  its API. This repository will then consume a revision-pinned vendored copy.
- [`demo-extensions`](../demo-extensions) is the future home for an optional
  generic native recorded-frame viewer and its Rust implementation. It must not
  contain algorithm-specific visualizers.
- [`sw-mlpl`](../sw-mlpl) should change only for measured language-wide gaps,
  such as a versioned frame protocol or generic browser Explorer host that
  cannot be expressed downstream.

Sibling repositories are read-only from this project. Exact work requests and
acceptance criteria are recorded in
[`docs/cross-repo-handoffs.md`](docs/cross-repo-handoffs.md).

## Planned learning path

The first three forcing-function lessons are deliberately different:

1. matrix multiplication for concept-by-concept stepping;
2. linear regression for iterative parameters, gradients, and metrics;
3. K-means for named assignment/update phases.

Only after those share a stable observation vocabulary will the project move
through MLP forward/backward state, PCA, attention, a tiny language model,
LoRA, and Engram. Existing sw-MLPL model and visualization primitives remain
the implementation; this repository does not build another transformer in
Rust.

Read the [architecture](docs/architecture.md), [delivery plan](docs/plan.md),
[saga queue](docs/sagas.md), and [capability ledger](docs/sw-mlpl-blockers.md)
before implementing a lesson. The original design discussion is retained in
[`docs/research.txt`](docs/research.txt).

## Development process

Work is divided into durable Agentrail steps. In each fresh session run
`agentrail next`, then `agentrail begin`; implement only that step; run focused
tests and the precommit gate; commit source and `.agentrail/` metadata; and
only then run `agentrail complete`. [`AGENTS.md`](AGENTS.md) contains the full
repository protocol.

The foundation gate is:

```sh
just check
```

It currently checks repository structure, documentation links, the generated
Agentrail briefing, MLPL style readiness, and invokes `sw-checklist` (accepting
its exact no-`Cargo.toml` result while this remains an MLPL-only repository).
Future executable steps must extend the gate with capability probes, demos, and
native mlplunit tests.

## Current status

The repository foundation and cross-repository contracts are being
established. No microscope lesson is claimed runnable yet. Recorded playback,
not reverse interpreter execution or pause/resume debugging, is the first
target.

Copyright (c) 2026 Michael A Wright. Distributed under the [MIT License](LICENSE).
