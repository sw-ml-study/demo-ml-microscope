# Cross-repository handoffs

This document is a work order for agents operating in sibling repositories.
It does not authorize changes from this repository. Each request should be
revalidated against artifacts produced here before its own saga begins.

## `../demo-mlpl-libraries`: shared MLPL mechanism

Trigger: at least matrix multiplication, linear regression, and K-means use the
same helper surface without lesson-specific branches.

The library agent should:

1. review the three consumers and freeze the smallest domain-neutral API;
2. add a `microscope` or `observation` module with its own unique public prefix,
   module comment, function docstrings, canonical formatting, mlplunit contract
   tests, API documentation, and catalog entry;
3. specify identity-return behavior, numeric name/step/value inputs, ordering,
   disconnected behavior, errors, and bounded summary policy;
4. extend the existing revision-pinned installer and hash lock evidence with a
   fixture consumer matching this repository;
5. publish an immutable revision for this repo to vendor in a separately
   authorized migration.

Do not move lesson names, phase choices, ML explanations, algorithms, or host
rendering into the library. Do not claim a richer protocol than the three
measured consumers prove.

## `../demo-extensions`: generic Rust/native viewer

Trigger: this repo has a versioned prerecorded observation artifact plus
headless acceptance fixtures and has demonstrated a need not met by static or
browser rendering.

The extension agent should:

1. define a versioned, renderer-neutral input envelope for bounded prerecorded
   frames and reject unknown versions, malformed shapes, non-finite values, and
   budget overflow deterministically;
2. implement generic tensor summaries, scalar cards, lines/bars, scatter,
   heatmaps, rank-3 slice selection, observation selection, and
   previous/next/play/seek controls in Rust;
3. reuse the established `winit`/`wgpu`, worker/parked-main Port, retained-state,
   and headless-test architecture where it is a clean fit;
4. keep ingestion, validation, storage, layout, rendering, and input handling
   responsibility-separated and within `sw-checklist` size limits;
5. prove the parser and state transitions headlessly; make interactive smoke
   checks opt-in; document ownership/copy/lifetime and retained-byte budgets;
6. expose only generic private-provider/public-MLPL-facade operations if live
   extension ingestion is later needed.

Forbidden Rust concepts include transformer, attention, PCA, K-means, LoRA,
Engram, optimizer, or lesson-specific viewer types. The first viewer consumes a
completed recording; it does not pause the MLPL evaluator.

## `../sw-mlpl`: language and browser host

Trigger: a minimal probe and at least three lessons show that downstream code
cannot preserve required general behavior. Requests must be split by concern.

Likely protocol agent work, if proven:

- specify a versioned event envelope able to group multiple observations at a
  logical step and carry semantic name, numeric shape/value, optional role/hint
  and annotation while preserving current `emit_frame` compatibility;
- define ordering, duplicate names, numeric fidelity, non-finite handling,
  disconnected behavior, error propagation, and explicit byte/frame budgets;
- prove evaluator, REPL/connect, compiler, and WASM parity with contract tests.

Likely browser agent work, after the protocol is stable:

- add a generic Explorer consumer with bounded retention, run/frame/observation
  navigation, play/pause/seek over retained data, shape-directed rendering,
  textual tensor summaries, rank-3 slice selection, and accessible static
  fallbacks;
- keep it algorithm-neutral and preserve existing REPL/editor/tutorial flows;
- test malformed/oversized events and deterministic eviction visibly.

Do not add an ML-specific syntax form, reverse execution, evaluator suspension,
a dashboard DSL, or special algorithm renderer as part of the first request.
Current `emit_frame` may already be sufficient for early lessons; this repo
must prove otherwise before opening upstream work.
