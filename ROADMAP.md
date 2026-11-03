# NeuaOS Roadmap

**Status:** Planning / pre-alpha  
**Version target:** 0.1 Alpha  
**Principle:** prove the desktop experience first; package a distribution only after the shell is usable.

This roadmap describes milestones, not guaranteed dates. Each milestone should be considered complete only when its acceptance criteria are met.

## Phase 0 — Project foundation

**Goal:** make the project understandable and reproducible.

Tasks:
- [x] Define project name and product direction.
- [x] Establish initial design principles.
- [x] Draft technical specification and architecture.
- [x] Choose project license.
- [x] Create Git repository and initial branch.
- [x] Add contribution and issue templates.
- [x] Record open architecture decisions.

Exit criteria:
- repository builds a minimal Qt 6 application;
- documented development dependencies;
- architecture decisions are tracked rather than silently assumed.

## Phase 1 — Neua Shell prototype

**Goal:** demonstrate the signature desktop experience without requiring a custom distribution.

Tasks:
- [ ] Create CMake-based Qt 6 / QML application.
- [ ] Implement app entry point and shell lifecycle.
- [ ] Add design tokens: colors, spacing, typography, radius, motion.
- [ ] Implement desktop background and clock.
- [ ] Implement translucent bottom Dock.
- [ ] Implement Neua Island prototype.
- [ ] Add basic widget layout.
- [ ] Add theme/effects settings.
- [ ] Add keyboard navigation and accessibility basics.

Exit criteria:
- shell launches as a normal user application on a supported Wayland development session;
- UI remains responsive while optional data providers are unavailable;
- transparency and animations can be reduced or disabled;
- no blocking I/O occurs on the UI thread.

## Phase 2 — Platform integration spike

**Goal:** choose a compositor based on tested requirements.

Tasks:
- [ ] Compare KWin, labwc, and selected wlroots-based options.
- [ ] Verify dock/panel and activity surface placement.
- [ ] Verify session startup and shell restart behavior.
- [ ] Test multi-monitor and fractional scaling behavior.
- [ ] Test NVIDIA GPU behavior on target hardware.
- [ ] Document selected compositor and known limitations.

Exit criteria:
- a working development session can host Neua Shell surfaces;
- all compositor selection checks in ARCHITECTURE.md are documented;
- no custom compositor is required for the first Alpha.

## Phase 3 — Neua Core foundations

**Goal:** connect the shell to real system state through small interfaces.

Tasks:
- [ ] Define shell-facing service interfaces.
- [ ] Add notification integration.
- [ ] Add power/battery information.
- [ ] Add appearance preferences persistence.
- [ ] Add session lifecycle handling.
- [ ] Add update-status provider (read-only initially).

Exit criteria:
- shell consumes system information through documented APIs;
- optional services can fail without crashing the shell;
- services run with least privilege.

## Phase 4 — First-party applications

**Goal:** provide a coherent basic desktop workflow.

Suggested order:
- [ ] Neua Settings.
- [ ] Neua Launcher.
- [ ] Neua File Manager (only after scope is defined).
- [ ] Shared component library and icon guidelines.

Exit criteria:
- applications share design tokens and behavior;
- keyboard and accessibility behavior is consistent;
- basic workflows work without network access.

## Phase 5 — Base distribution and recovery

**Goal:** select and package a maintainable Linux base.

Tasks:
- [ ] Compare candidate distributions against ARCHITECTURE.md.
- [ ] Select base and document the rationale.
- [ ] Define package set and default services.
- [ ] Create reproducible packaging scripts.
- [ ] Implement controlled update workflow.
- [ ] Implement and test rollback/recovery.
- [ ] Define NVIDIA and gaming support policy.
- [ ] Create a VM-testable installation image.

Exit criteria:
- installation image boots in a VM;
- update and rollback procedures are documented and tested;
- interrupted update and failed-boot recovery scenarios are tested;
- personal-file backup limitations are clearly explained.

## Phase 6 — Neua Connect

**Goal:** optional, secure Android integration.

Tasks:
- [ ] Define pairing and threat model.
- [ ] Prototype authenticated local-network connection.
- [ ] Implement notification relay.
- [ ] Implement file transfer.
- [ ] Implement clipboard sync with user controls.
- [ ] Add media controls.
- [ ] Investigate official Glyph capabilities on selected Nothing models.
- [ ] Publish a tested Android device compatibility matrix.

Exit criteria:
- pairing is explicit and revocable;
- transport is authenticated and encrypted;
- unsupported phone features fail gracefully;
- NeuaOS remains fully usable when no phone is connected.

## Phase 7 — NeuaOS 0.1 Alpha

**Goal:** deliver a testable personal system image.

Release checklist:
- [ ] Bootable installation image.
- [ ] Working Neua Shell session.
- [ ] Dock, Island, widgets, launcher, and settings.
- [ ] Basic system integration.
- [ ] Controlled updates and tested recovery.
- [ ] Known hardware limitations documented.
- [ ] Performance baseline published.
- [ ] Installation and recovery guide written.

Alpha means suitable for testing, not guaranteed stable for daily use.

## Later directions — after Alpha

- more first-party applications;
- improved multi-monitor and workspace experience;
- laptop power optimization;
- expanded NVIDIA and gaming validation;
- polished Neua Connect and supported Nothing Glyph features;
- accessibility and localization;
- reproducible release pipeline and signed artifacts.

## Release principles

- No release date is promised until the acceptance criteria are met.
- Performance claims must include test conditions and measurements.
- A feature is not complete merely because it looks correct in a mockup.
- Updates must have a documented recovery path before being recommended for daily use.
- Keep the system useful without optional cloud services or a connected phone.
