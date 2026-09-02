# MM01: matrix multiplication under the microscope

## Teaching claim

For rank-two `A:[row,inner]` and `B:[inner,column]`, every cell of
`C = A @ B` is one row of A dotted with one column of B. The shared inner
dimension is consumed; A's row axis and B's column axis remain.

The exact fixture is:

```text
A = [[1,2],     B = [[5,6],     A @ B = [[19,22],
     [3,4]]          [7,8]]              [43,50]]
```

The active output cell is `C[1,0]`. It selects `[3,4]` and `[5,7]`, forms
products `[15,28]`, and exposes running sums `[15,43]`. The last value is the
completed cell. Four explicit row-column dots derive the whole output, and a
separate assertion checks exact equality with native rank-two `matmul`.

![The active blue row and green column produce products fifteen and twenty-eight, partial sums fifteen and forty-three, and the highlighted output cell forty-three](../assets/previews/matrix-microscope.svg)

## Recorded timeline

| Step | Observation names | Meaning |
|---:|---|---|
| 0 | `matmul/input/left`, `matmul/input/right` | Both input matrices and their shapes |
| 1 | `matmul/active/row`, `matmul/active/column` | The selected operands for `C[1,0]` |
| 2 | `matmul/active/products` | Aligned component products `[15,28]` |
| 3 | `matmul/active/partial-sums` | Accumulator states `[15,43]` |
| 4 | `matmul/output/derived`, `matmul/output/native` | Readable derivation and independent oracle |

Names and values are authored by the MLPL lesson. A Yew viewer should group by
step, preserve observation order, and choose generic shape-directed views; it
must not contain matrix-specific Rust rendering logic.

## Run and verify

```sh
just matrix
just matrix-fixture
just matrix-recording
```

`just matrix` runs the standalone lesson and compares its generated SVG with
the committed preview. `just matrix-fixture` validates schema, shape products,
ordering, and declared budgets. `just matrix-recording` runs the lesson over
the real loopback SSE path and requires its eight frame events to equal the
committed Yew integration fixture.

## Boundaries

- This fixture uses exact small integers, so no floating-point tolerance is
  needed.
- It teaches rank-two multiplication only, not batched or multi-head matmul.
- The reusable helper is intentionally 2-by-2; it exists to expose the concept,
  not to replace the native general operation.
- The visual is redundant evidence. Native mlplunit assertions and terminal
  arrays remain authoritative for nonvisual and accessibility use.
- Playback reviews retained frames after/during an SSE run. It does not pause,
  rewind, or reverse the evaluator.
- The checked static SVG is the current inline artifact. The Yew workstream
  should later generate a short five-step GIF from this exact recording for
  README motion and may export WebM/MP4 for a higher-quality linked demo.
