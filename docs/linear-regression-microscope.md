# LR01: linear regression under the microscope

## Teaching claim

For four exact samples on `y = 2x + 1`, full-batch gradient descent can update
two parameters—slope and bias—by differentiating mean squared error explicitly.
Predictions approach labels, residuals and gradients shrink, loss falls, and
the parameter pair approaches `[2,1]`.

The MLPL lesson computes, rather than hides, each step:

```text
prediction[i] = slope * x[i] + bias
residual[i]   = prediction[i] - y[i]
loss          = mean(residual * residual)
gradient      = [2*mean(residual*x), 2*mean(residual)]
parameters    = parameters - 0.1 * gradient
```

The initial state has predictions `[0,0,0,0]`, residuals `[-1,-3,-5,-7]`,
loss `21`, and gradient `[-17,-8]`. The first update produces parameters
`[1.7,0.8]` and independently recomputed loss `0.535`. After eight updates,
loss is approximately `0.000365775`, slope is approximately `2.01487`, and
bias is approximately `0.96824`.

![Four exact points and their fitted line beside a steeply falling loss curve and slope-bias parameter trajectory](../assets/previews/linear-regression-microscope.svg)

## Recorded timeline

The algorithm performs all eight updates and retains pedagogically useful
checkpoints `0`, `1`, `2`, `4`, and `8`. This keeps the recording small without
silently changing or sampling any retained tensor.

Every checkpoint contains:

- `regression/model/parameters` — `[slope,bias]`;
- `regression/model/predictions` — four fitted values;
- `regression/model/residuals` — prediction minus label;
- `regression/training/loss` — scalar mean squared error;
- `regression/training/gradient` — analytic `[dL/dslope,dL/dbias]`;
- `regression/trajectory/point` — `[slope,bias,loss]` for a generic path view.

Step zero also contains the authoritative feature and label vectors. The
recording has five frames, 32 observations, and 88 numeric values, within its
declared budgets.

## Run and verify

```sh
just regression
just regression-fixture
just regression-recording
```

The first command runs the standalone MLPL lesson and verifies its generated
SVG. The second validates recording schema, shapes, checkpoints, convergence,
and budgets. The third submits the lesson to a real loopback sw-MLPL server and
requires every retained SSE value to equal the committed Yew fixture.

## Boundaries

- This is deterministic full-batch gradient descent, not SGD or minibatching.
- Gradients are explicit analytic MSE derivatives. The lesson does not claim
  to demonstrate sw-MLPL autograd yet.
- The fixture demonstrates convergence for one well-scaled convex problem; it
  is not a proof that this learning rate converges for arbitrary data.
- Tests use exact first-step evidence and documented tolerances for later
  floating-point convergence.
- The static SVG summarizes the run. Future animation must replay the retained
  states, respect reduced-motion preferences, and retain manual controls.
