# ADR-0003: Update and rollback model

## Status
Proposed

## Context
Controlled updates with a recoverable known-good state are a product
requirement. Two broad models exist:

- **Snapshot-based:** a mutable system with filesystem snapshots
  (for example Btrfs + Snapper), rollback via snapshot selection.
- **Image-based / transactional:** read-only system image with atomic
  updates and rollback to a previous deployment (for example Fedora
  Silverblue, openSUSE Aeon).

The model affects filesystem layout and packaging, so it should be
decided before packaging work in Phase 5 begins.

## Decision
Start with a **snapshot-based** model as the working assumption, since it
is simpler to bootstrap and is well supported on the openSUSE candidates.
Treat image-based updates as an alternative to evaluate if the selected
base supports them natively and the added constraints are acceptable.

The final choice is made in Phase 5 together with the base selection.

## Consequences
- (+) Snapshot-based rollback is well documented and does not require a
  read-only `/usr` or a new packaging model.
- (−) Snapshots do not protect user files stored outside snapshot scope;
  this must be stated clearly in user-facing documentation (already noted
  in ARCHITECTURE.md §9).
- A late switch to image-based updates would require reworking packaging
  and default filesystem layout; avoid designing around mutable-system
  assumptions that would be hard to reverse.

## Alternatives
- Committing to image-based updates now: rejected — depends on base and
  is harder to prototype without the base in place.