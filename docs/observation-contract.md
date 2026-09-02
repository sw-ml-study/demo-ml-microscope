# Recorded observation contract

Status: measured foundation contract, version 0. It is intentionally narrower
than a future renderer-neutral interchange format.

## Evidence baseline

The local probes ran on 2026-09-01 with `mlpl-repl 0.20.0`, build commit
`42b227ff`, native `mlplunit 0.1.0`, and the adjacent release `mlpl-serve`.
The inspected adjacent source was commit
`2d44f942e78009ee9d4bfaafc3512780ceb20c3a`.

Run the same evidence with:

```sh
just tests
just emit-frame-errors
just emit-frame-sse
```

The SSE probe binds only loopback. Override its default port with
`MICROSCOPE_TEST_PORT` if necessary.

## Proven producer behavior

An initial observation is exactly:

```mlpl
observed = emit_frame("semantic/name", step, value)
```

- The name is a string literal. A variable containing a string is rejected.
- The step and value evaluate to numeric sw-MLPL arrays. The contract uses a
  non-negative integer scalar step; coercion of floats, negative numbers,
  empty steps, or non-scalar steps is deliberately outside the contract.
- Scalar, empty rank-one, ordinary rank-one, rank-two, and rank-three numeric
  values return unchanged under disconnected native execution.
- With the connect sink installed, one SSE `event: frame` is emitted per call.
- The payload has `name`, integer `step`, `shape`, and flat row-major numeric
  `values`. The local probe preserves rank-one `[2]`, rank-two `[2,2]`, and
  rank-three `[2,1,1]` shapes and exact small fixture values.
- Calls arrive on SSE in program order, including several names sharing one
  logical step. A run has `ready`, ordered frame events, then one `done` event.
- Wrong arity fails visibly. Disconnected execution is a no-op apart from
  returning the observed value.

## Version-zero microscope convention

Until a richer protocol is proven, lessons must:

1. use literal slash-separated semantic names, for example
   `matmul/row` and `matmul/products`;
2. use non-negative integer scalar steps;
3. emit only bounded numeric values and retain authoritative textual/numeric
   assertions independently of the frame stream;
4. treat all observations with the same step as one logical frame and preserve
   call order within it;
5. use `emit_frame` directly or through an identity-returning MLPL helper;
6. record every SSE frame in the downstream recorder rather than relying on the
   current browser live-frame store.

Names are semantic identifiers, not presentation instructions. A future host
may infer presentation from shape. No producer may assume that `[n,2]` always
means scatter data or encode hidden metadata in numeric values.

## Measured limitations

- The browser/WASM `frame_trace` retains only the latest observation for each
  evaluation generation. Its sequence counter proves updates occurred, but it
  cannot supply recorded rewind or multiple observations from a logical step.
- Frame events carry no protocol version, run identifier inside the payload,
  annotation, semantic role, visualization hint, dtype, axis labels, timestamp,
  phase label, per-frame byte budget, or total-retention budget.
- The public builtin requires a literal name, which prevents a general helper
  from accepting a runtime name and forwarding it to `emit_frame`.
- Malformed browser frame JSON is silently dropped, and its shape/value parser
  filters invalid elements rather than validating shape-product equality.
- The live sink transports all numeric values as `f64`. Non-finite behavior and
  JSON representation are not accepted by this contract.
- Interpreter, compiler, and pure-WASM parity beyond the inspected connect
  consumer remain unproven locally.

These limitations do not block the first matrix microscope. Its calls and
names can be literal, its tensors are tiny, and a local recorder can retain the
ordered SSE stream. They do block claiming that the current browser live panel
is already a general replayable microscope.
