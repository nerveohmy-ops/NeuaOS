# ADR-0002: Linux base distribution

## Status
Proposed

## Context
NeuaOS will reuse an established Linux distribution as its base. The base
must provide a current Qt 6, Wayland, compiler and GPU-driver packages,
and a viable recovery story. Candidates carry different maintenance costs:

- openSUSE Tumbleweed: current packages, Snapper tooling, but rolling
  updates create churn for a single developer.
- openSUSE Slowroll: slower cadence, still snapshot-capable.
- Fedora: strong Wayland and Qt story; Silverblue provides an
  image-based update model worth evaluating.

The shell must not depend on the base before the compositor spike and
core service work are complete.

## Decision
Develop Neua Shell independently of the base, on a conventional Linux
development environment. Defer the base selection until after Phase 2
(compositor) and Phase 3 (core services). Keep Tumbleweed, Slowroll and
Fedora as candidates, with Tumbleweed as the initial working assumption.

## Consequences
- (+) Shell work is not blocked by base selection.
- (+) Packaging decisions are deliberately deferred to Phase 5.
- (−) Some integration choices (paths, service names) remain provisional
  until the base is chosen; keep them behind interfaces.
- Revisit if Tumbleweed update churn starts breaking the shell build more
  than roughly once per month.

## Alternatives
- Selecting a base immediately: rejected — premature, constrains the
  compositor spike.
- Building an independent distribution from scratch: out of scope for
  the first alpha.