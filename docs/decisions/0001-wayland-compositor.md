# ADR-0001: Wayland compositor

## Status
Proposed

## Context
Neua Shell is a Qt/QML desktop application, not a compositor. Hosting
panels, a dock, and an activity surface above normal windows requires
compositor-side protocol support (for example wlr-layer-shell on
wlroots-based compositors, or KWin-specific integration).

Candidate families differ significantly in integration model:
- KWin: mature, rich ecosystem, but KDE-specific mechanisms.
- labwc: lightweight wlroots stacking compositor with layer-shell support.
- Other wlroots-based compositors: to be considered only if they satisfy
  the protocol and maintenance requirements.

The choice affects how much shell code must be adapted, so it must be
validated by a technical spike, not by visual preference.

## Decision
Run the Phase 2 spike against **labwc** and **KWin** as the two initial
candidates. Select the compositor only after the acceptance checks in
ARCHITECTURE.md §4 pass on at least one candidate.

## Consequences
- (+) labwc provides a simple, fast path to validate layer-shell
  integration for dock and activity surfaces.
- (−) KWin offers more built-in infrastructure (effects, settings)
  but is harder to adapt to a third-party shell.
- Revisit this ADR if labwc proves unstable across shell restarts,
  multi-monitor changes, or NVIDIA hardware.

## Alternatives
- Writing a custom compositor: explicitly a non-goal for the first alpha.
- Committing to KWin without a spike: rejected — too risky given the
  unknown cost of shell-surface integration.