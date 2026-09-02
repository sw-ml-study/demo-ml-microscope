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

## `../demo-extensions`: preferred Rust/Yew WASM microscope

Trigger: this repo has the measured ordered SSE contract plus matrix lesson
fixtures. Yew/WASM is the preferred full-featured UI; existing native graphics
support is optional follow-up work.

The extension agent should:

1. create a Yew WASM application that connects to the existing sw-MLPL session
   and `eval_stream` APIs, runs user-editable MLPL, and records every ordered
   `event: frame` rather than using the latest-only live-frame store;
2. define a versioned internal, renderer-neutral run/frame/observation model and
   reject malformed shapes, non-finite values, unknown versions, and byte/frame
   budget overflow deterministically before state enters the UI;
3. implement source, lesson/explanation, run, frame, and observation navigation;
   previous/next/play/seek controls; scalar cards; tensor summaries; lines/bars;
   scatter; heatmaps; rank-three slice selection; and accessible text/table
   fallbacks in Rust/Yew;
4. group observations by numeric step while preserving call order and literal
   slash-separated names. Keep run status, transport errors, retention/eviction,
   and disconnected state visible;
5. separate transport, validation, bounded retention, playback reducer,
   shape-directed view planning, and Yew components. Run `sw-checklist` there
   because this is the Rust workstream to which that tool applies;
6. test parsing, budgets, reducer transitions, ordering, selection, playback,
   reconnect/error behavior, and view planning natively/headlessly. Add browser
   WASM tests for component wiring and keep manual browser smoke opt-in;
7. consume matrix fixtures from this repository as the first integration
   contract, then add regression and K-means without algorithm-specific Rust;
8. only after the 2-D browser path is accepted, evaluate the existing
   `wgpu`/`winit` support as an optional renderer for 3-D surfaces, PCA clouds,
   or desktop use. Share the protocol/model rather than forking semantics.

Forbidden Rust concepts include transformer, attention, PCA, K-means, LoRA,
Engram, optimizer, or lesson-specific viewer types. The first Yew UI records a
run delivered by SSE and replays retained frames; it does not pause or reverse
the MLPL evaluator.

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

Possible core browser/server work, only when the Yew implementation proves it
cannot remain downstream:

- expose or stabilize only the generic session/SSE/CORS/protocol behavior the
  external Yew client needs;
- add explicit event/run budgets or metadata only when downstream validation
  cannot provide the required semantics;
- preserve existing REPL/editor/tutorial flows and prove compatibility across
  interpreter, server, and WASM paths.

Do not add an ML-specific syntax form, reverse execution, evaluator suspension,
a dashboard DSL, or special algorithm renderer as part of the first request.
Current `emit_frame` may already be sufficient for early lessons; this repo
must prove otherwise before opening upstream work.
