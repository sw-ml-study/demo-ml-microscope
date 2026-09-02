# Rust/Yew microscope viewer handoff

Status: implementation-ready work order for an agent operating in
`../demo-extensions`. This repository does not authorize or contain the Rust
implementation.

## Pinned producer inputs

Clone or vendor `sw-ml-study/demo-ml-microscope` at commit
`ff15ec7da2f9055983aa72c43dfe01da92a2d4aa`. The machine-readable entry point
is [`fixtures/yew/index-v1.json`](../fixtures/yew/index-v1.json). It pins hashes,
counts, steps, lesson sources, previews, and recordings for:

- MM01: five consecutive concept frames, eight observations, 24 values;
- LR01: five nonconsecutive training checkpoints, 32 observations, 88 values.
- KM01: five alternating phase frames, 14 observations, 74 values.

Both use [`recording-schema-v0.json`](../fixtures/yew/recording-schema-v0.json).
The JSON Schema describes structure. Consumer code must additionally enforce
shape-product equality, finite values, monotonic unique steps, and the four
declared budgets before retaining a recording.

The producer acceptance command is:

```sh
just yew-handoff
```

The extension agent must pin the producer revision rather than reading an
adjacent mutable checkout during build or tests.

## Target repository shape

Suggested additions in `../demo-extensions`:

```text
crates/mlpl-microscope-model/       pure protocol, validation, reducer, view plans
crates/mlpl-microscope-web/         Yew/WASM transport and components
integration/ml-microscope/          pinned fixtures, provenance lock, acceptance
scripts/run-microscope-web          local two-service launcher guidance
scripts/check-microscope-web        native + wasm/browser checks
docs/ml-microscope-web.md           architecture, run, deploy, limitations
```

If repository size rules favor fewer crates, keep the same module boundaries.
Run `sw-checklist` on all Rust code because this is the Rust workstream.

## Pure model boundary

`mlpl-microscope-model` must compile and test natively without DOM, browser,
network, Yew, or sw-MLPL evaluator dependencies. Suggested responsibility-based
types are:

```text
Recording { lesson, budgets, frames }
Frame { step, observations }
Observation { name, shape, values }
ViewerState { run_status, frame_index, observation_index, playback, motion }
Action { Load, Previous, Next, SeekIndex, Select, Play, Pause, Tick, Fail }
ViewPlan { ScalarCard, VectorTable, LineOrBar, MatrixHeatmap, TensorSlices }
```

Names are opaque semantic paths. Do not create matrix-, regression-, optimizer-,
attention-, or K-means-specific Rust types. A repeated observation name across
frames may form a generic series, but its meaning remains producer-owned.

## Validation order

Reject before allocation/retention in this order:

1. unsupported schema or version;
2. missing/duplicate structural fields and empty lesson/observation names;
3. negative dimensions or steps, non-finite numeric values, and integer
   conversion overflow;
4. frame, observations-per-frame, values-per-observation, and total-value
   budget overflow using checked arithmetic;
5. shape product overflow or mismatch with value count;
6. non-increasing/duplicate steps.

Return structured user-visible errors. Never silently filter malformed shape or
value entries, silently truncate, or partially retain a rejected run.

## Reducer semantics

- `Load`: atomically replace state only after complete validation; select frame
  index zero and observation zero; playback is paused.
- `Previous`/`Next`: move by retained frame index, not numeric step arithmetic.
  Clamp at the first/last frame and pause at the last frame.
- `SeekIndex(i)`: select one retained index after bounds validation. LR01 proves
  that moving from step 2 to step 4 is one Next action.
- `Select(i)`: select an observation within the current frame. When frame
  changes, preserve the selected semantic name if present; otherwise select the
  first observation.
- `Play`: set playing only when more than one frame exists and the selection is
  not at the last frame. From the last frame, restart at index zero explicitly.
- `Tick`: advance exactly one frame only while playing. Reaching the final frame
  pauses. Timing belongs to the host, not the reducer.
- `Pause`: idempotently stop ticks.
- `Fail`: preserve the last accepted recording, stop playback, and expose the
  new transport/validation error separately.

Playback never controls, pauses, or reverses the MLPL evaluator. It reviews
retained observations.

## Yew/WASM boundary

The web crate owns:

- session creation and program submission to the configured sw-MLPL server;
- incremental SSE parsing across arbitrary chunk boundaries;
- `ready`, ordered `frame`, `done`, and `error` state;
- assembling live observations by numeric step while preserving call order;
- dispatching pure reducer actions;
- accessible components and CSS presentation;
- deterministic import of prerecorded fixtures for offline/demo mode.

Never render event strings as trusted HTML or accept producer SVG/JavaScript.
Text uses normal escaped DOM nodes. Numeric graphics are constructed by the
viewer from validated arrays.

## Shape-directed views

Version one needs only generic plans:

- rank zero: numeric card with exact value and finite summary;
- rank one: table always, with optional line/bar for bounded length;
- rank two: table plus heatmap, with rows/columns and min/max legend;
- rank three: bounded slice selector displaying one rank-two heatmap;
- other ranks: shape, count, min/max/mean, and bounded flat table fallback;
- repeated same-name scalar/vector observations: optional generic time series
  keyed by retained step;
- repeated vectors of length two or three: optional generic trajectory view,
  while retaining the table and avoiding semantic axis labels not supplied by
  the producer.

Every view shows semantic name, shape, current step, and exact/tabular values.
Color and animation are redundant.

## Required UI

```text
source/editor + Run
run status / error
lesson title
frame label: retained index and producer step
Previous | Play/Pause | Next | seek slider
observation list grouped by slash-separated name segments
selected tensor view + exact table/summary
reduced-motion status
```

Keyboard: Left/Right for frame navigation when focus is not in an editor,
Space for play/pause on the focused control, Home/End for first/last. Use real
buttons, labels, focus indicators, and ARIA only where native semantics are
insufficient.

## Motion policy

Default to paused. CSS may transition between selected states. Under
`prefers-reduced-motion: reduce`, set transition/animation duration to zero and
do not autoplay. Manual controls and current-state labels remain identical.
No meaning may depend on motion or color.

## Acceptance cases

Native/headless model tests must cover:

- all pinned fixtures parse and match indexed hashes/counts/steps;
- every validation failure listed above, including checked-multiply overflow;
- Next/Previous clamp, Seek bounds, Play/Restart/Tick/Pause, final auto-pause;
- LR01 nonconsecutive steps navigate by retained index;
- semantic-name selection preservation and fallback;
- Fail retains the last accepted run but stops playback;
- generic view plans for scalar, vectors, matrices, rank-three, empty and
  unsupported-rank inputs;
- series/trajectory planning uses repeated names only, not lesson identifiers.

WASM/browser tests must cover:

- SSE events split at every meaningful byte boundary assemble identically;
- ready/frame/done and ready/frame/error flows;
- all controls dispatch expected reducer actions;
- keyboard and focus behavior;
- reduced-motion media query disables transitions;
- exact table/text fallback exists for every graphic;
- malformed/over-budget recordings show visible errors and no partial run.

Manual smoke: load both prerecorded fixtures, then connect to a local sw-MLPL
server and run both sources. Interactive smoke is supplementary.

## Build, run, and deploy contract

The extension agent should add thin `just` recipes backed by scripts:

```sh
just microscope-web-check     # native model tests, wasm tests, formatting, sw-checklist
just microscope-web           # serve Yew locally and print sw-MLPL server command
just microscope-web-build     # locked release build into an ignored dist directory
```

For a Trunk-based implementation, the documented local flow should be
equivalent to:

```sh
# terminal 1: adjacent sw-MLPL server permits the Yew origin
../sw-mlpl/target/release/mlpl-serve \
  --bind 127.0.0.1:6464 --auth disabled \
  --cors-allow http://127.0.0.1:8080

# terminal 2: Yew development server
trunk serve --address 127.0.0.1 --port 8080
```

Pin Rust/Yew/WASM tooling and dependencies in the consumer lockfile. Scripts
select existing tools and must not install or overwrite user binaries.

The release build must support a configurable sw-MLPL base URL and a
prerecorded fixture mode. Deploy static assets under the owning repository's
chosen Pages/static hosting workflow with the correct public URL. Do not claim
live execution unless a reachable, explicitly CORS-configured sw-MLPL server is
also deployed; offline fixture playback remains fully functional without it.

## Exit criteria

The original offline handoff was delivered for MM01 and LR01 at
`demo-extensions` commits `2ef0e33` and `3ecd025`. Its next integration is
complete when all three pinned fixtures can be
loaded offline and stepped with Previous/Next/Play/Pause/Seek, all model and
browser acceptance tests pass, the Rust gate including `sw-checklist` passes,
and a documented local URL displays exact numeric fallbacks. Live SSE execution
is the next acceptance layer, not permission to weaken offline playback.
