# Graphics and animation options

## Decision

Use a Rust/Yew WASM application as the primary interactive microscope. It will
consume ordered sw-MLPL SSE observations, retain bounded run history, and render
generic views from observation shape and metadata. The MLPL program remains the
source of algorithm semantics.

Use CSS transitions inside Yew for responsive state changes. Publish a static
SVG as the canonical documentation fallback, a short generated GIF when inline
README motion materially improves the explanation, and optional WebM plus H.264
MP4 walkthroughs for higher-quality linked playback. Treat animated SVG and
animated WebP as optional exports. Use the existing native graphics extension
only for desktop, 3-D, or performance cases that the browser implementation
cannot serve well.

## Why this split

No one format satisfies interaction, accessibility, fidelity, portability,
repository review, and social sharing.

| Option | Best role | Inline README | Decision |
|---|---|---|---|
| Yew/WASM | Full source/run/timeline/tensor interaction | No; link to deployed app | Primary application |
| CSS animation | Transitions between selected retained states in Yew | GitHub strips/limits arbitrary active content | Use inside Yew only |
| Static SVG | Exact diagrams, accessibility, reviewable fallback | Yes | Canonical checked artifact |
| GIF | Short deterministic loop showing a few steps | Yes, broadly reliable | Preferred inline animation |
| Animated SVG | Compact vector animation | Static SVG displays, but motion through sanitized/proxied rendering is not a dependable contract | Optional export |
| Animated WebP | Smaller raster animation than GIF | Browser/GitHub context support is less conservative than GIF | Optional export |
| WebM | High-quality, compact walkthrough | Do not depend on a repository-relative README player | Link/release asset |
| H.264 MP4 | Broad video playback compatibility | Do not make it the only README explanation | Preferred linked video fallback |
| Native 2-D/3-D extension | Desktop/GPU views, large scenes, 3-D interaction | No | Optional second renderer |

GitHub documents inline rendering for PNG, GIF, JPEG, and SVG and accepts
MP4/MOV/WebM attachments, while noting that video codec support varies by
browser and recommending H.264 for compatibility. README files support relative
image and file links. Because attachment-player behavior is not the same as a
portable repository-relative README embed, the project uses image formats
inline and links video or the deployed Yew application.

References:

- [GitHub supported image and media attachments](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/attaching-files)
- [GitHub README relative links and image paths](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes)

## Runtime architecture

The Yew app should have separable Rust responsibilities:

1. connect/create a sw-MLPL session and submit editable lesson source;
2. parse ordered `ready`, `frame`, terminal, and error SSE events;
3. validate schema, shape products, finite values, and explicit budgets;
4. group observations by run and numeric step while preserving call order;
5. reduce previous/next/play/pause/seek/select actions into deterministic UI
   state;
6. plan generic views from shape and optional future hints;
7. render accessible DOM/SVG/canvas components without ML-algorithm-specific
   Rust types.

CSS transitions interpolate presentation between reducer states. They must not
advance the model, generate hidden values, or become the only evidence that a
step changed.

## Accessibility and motion

- Every graphic needs useful surrounding text and alt text or an SVG
  `title`/`desc`.
- Every animated lesson needs manual previous/next controls and a visible
  current-step label.
- Respect `prefers-reduced-motion`; disable autoplay and interpolation when
  requested while retaining instantaneous state changes.
- Never encode meaning only in motion or color. Use labels, numbers, shapes,
  borders, and tables as redundant evidence.
- Static SVG and terminal/numeric output remain usable without JavaScript,
  WASM, animation, or color vision.
- Video is supplementary because README video lacks the dependable alt-text
  path available to images.

## Generation and acceptance

All media must be derived from the same committed bounded recording used by
the interactive client. Media generation must not reimplement the algorithm.

The acceptance hierarchy is:

1. native mlplunit assertions establish numeric correctness;
2. live SSE must equal the committed recording fixture;
3. the static SVG must be freshness-checked against the MLPL lesson;
4. Yew parser/reducer/view planning must have headless Rust tests in
   `demo-extensions`, including malformed and over-budget inputs;
5. GIF/video generation must be deterministic enough for a freshness or frame
   manifest check; manual visual review is supplementary;
6. interactive browser and native smoke tests are opt-in, never the sole gate.

Suggested export policy:

- Static SVG: commit for every lesson where a visual relationship matters.
- GIF: commit only a short README showcase, preferably 5–10 seconds, small
  dimensions, restrained frame rate, and below GitHub's image-size limit.
- WebM plus H.264 MP4: attach to a release or publish with the deployed demo;
  avoid bloating normal git history with large duplicated video binaries.
- Animated SVG/WebP: generate only when they improve a specific distribution
  target; keep the static SVG beside them.

## Choosing a renderer

Use Yew DOM/SVG for controls, tables, small matrices, vector diagrams, line/bar
charts, and accessible labels. Use browser canvas only after measurement shows
SVG/DOM is inadequate for dense heatmaps or many points. Consider the native
extension for 3-D PCA/embedding clouds, loss surfaces, GPU-heavy scenes, or a
desktop/offline experience. The native renderer must consume the same recording
model and must not acquire algorithm-specific semantics.

## Viewing the current MM01 deliverable

The current deliverable is a checked static microscope plus executable MLPL
and a deterministic recording fixture. The Yew timeline UI and animated GIF do
not exist yet.

From the repository root:

```sh
just matrix
```

This executes `demos/matrix_microscope.mlpl`, prints its numeric teaching
contract, generates a temporary SVG, and verifies that it exactly matches the
committed preview.

Open the committed preview directly:

```sh
open assets/previews/matrix-microscope.svg       # macOS
xdg-open assets/previews/matrix-microscope.svg   # Linux desktop
```

Or open `README.md` in a Markdown preview/GitHub; the same SVG is embedded
inline. The files can also be inspected directly:

- [`assets/previews/matrix-microscope.svg`](../assets/previews/matrix-microscope.svg)
- [`demos/matrix_microscope.mlpl`](../demos/matrix_microscope.mlpl)
- [`fixtures/yew/matrix-run-v0.json`](../fixtures/yew/matrix-run-v0.json)
- [`docs/matrix-microscope.md`](matrix-microscope.md)

To validate the future Yew integration input against a real sw-MLPL SSE run:

```sh
just matrix-fixture
just matrix-recording
```

`matrix-recording` binds a loopback test server. Override the port with
`MICROSCOPE_MATRIX_PORT` if the default is occupied.
