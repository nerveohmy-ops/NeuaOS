# NeuaOS Architecture

**Status:** Proposed architecture, version 0.1  
**Decision maturity:** Initial direction; compositor and Linux base remain open.

## 1. Goals and constraints

NeuaOS will be a Linux-based desktop operating system with a custom Qt/QML shell and a small set of first-party services and applications.

Primary goals:

- keep the system base maintainable by reusing an established distribution;
- own the desktop experience and visual identity;
- keep shell components modular and testable;
- support controlled updates and a documented recovery path;
- keep resource use measurable and avoid unnecessary resident processes;
- leave room for optional Android integration.

Constraints:

- the project begins with one developer and limited hardware for testing;
- the first development environment may be a normal Linux desktop or VM;
- hardware-specific support, especially NVIDIA, must be validated on actual machines;
- no Linux base has been selected yet.

## 2. High-level layers

```text
+--------------------------------------------------------------+
|                        Neua Shell                            |
| Desktop | Dock | Island | Widgets | Launcher | Shell Settings|
+------------------------------+-------------------------------+
                               |
                     Shell APIs / D-Bus
                               |
+------------------------------+-------------------------------+
|                         Neua Core                            |
| Notifications | Power | Appearance | Session | Update status |
+------------------------------+-------------------------------+
                               |
              Desktop integration / compositor APIs
                               |
+------------------------------+-------------------------------+
|              Wayland compositor / window manager             |
|       Candidate to be evaluated; not yet locked in            |
+------------------------------+-------------------------------+
                               |
+------------------------------+-------------------------------+
|          Linux kernel + drivers + system base                 |
|     systemd and base distribution services / package tools    |
+--------------------------------------------------------------+

Optional companion path:
Android companion <---- authenticated local network ----> Neua Connect
```

The shell is a user-space desktop application. It does not replace the kernel, display server protocol, or compositor.

## 3. Component responsibilities

### 3.1 Neua Shell

The shell owns the user-facing desktop surfaces:

- **Desktop:** wallpaper, desktop-level interaction, workspace overview.
- **Dock:** pinned and running applications, launch and focus actions.
- **Neua Island:** compact activity surface for media, transfers, notifications, and other transient tasks.
- **Widgets:** optional, independently loadable information surfaces.
- **Launcher:** application search and launch.
- **Shell Settings:** appearance, layout, animation, and shell behavior.

Implementation direction:

- Qt 6 and Qt Quick / QML for UI composition and animation.
- C++20 for platform integration, models, and performance-sensitive logic.
- CMake for builds.
- Qt Quick Controls only where they can be styled consistently; custom controls should be introduced selectively, not for every widget.

Keep UI and platform integration separate. QML should call stable C++ models/interfaces rather than directly managing system processes.

### 3.2 Neua Core

Neua Core should not become a monolithic daemon. Prefer small services or adapters with clear responsibilities.

Candidate responsibilities:

- appearance settings and theme preferences;
- notification aggregation or shell-facing notification model;
- power and battery information;
- session state and shell lifecycle;
- update status and rollback information.

Use existing desktop/system services where possible. Do not duplicate functionality already provided reliably by the base system. D-Bus is the preferred integration mechanism when interoperating with Linux desktop services.

### 3.3 Neua Apps

First-party applications should share design tokens and reusable QML components, but remain independently launchable.

Suggested order:

1. Settings — needed to configure the shell.
2. Launcher — needed for everyday navigation.
3. File Manager — larger scope; start only after the shell foundations are stable.

### 3.4 Neua Connect

Neua Connect is an optional Android companion, not a dependency for booting or using NeuaOS.

Potential features:

- notification relay;
- file transfer;
- clipboard sync;
- media controls;
- device status;
- optional Glyph-related features on compatible Nothing devices, subject to official API availability and model/OS restrictions.

Security requirements:

- explicit pairing initiated by the user;
- authenticated and encrypted communication;
- no unauthenticated discovery-to-control path;
- per-feature permissions and a visible disconnect/revoke action;
- no assumption that all Android or Nothing models expose the same capabilities.

KDE Connect may be evaluated or integrated as an early foundation rather than reimplementing mature functionality immediately.

## 4. Compositor strategy — an open decision

A Qt/QML shell and a Wayland compositor are separate pieces of software. The compositor handles display output, input routing, window management, workspaces, and shell surfaces.

Do not commit to a compositor based only on visual preference. Run a technical spike comparing:

- **KWin:** mature compositor and strong KDE ecosystem; investigate the supported way to host custom shell surfaces and integrate session behavior.
- **labwc:** lighter stacking compositor; verify panel/shell surface support and integration requirements.
- **wlroots-based alternatives:** evaluate only if they provide the protocols and maintenance profile required by the project.

Acceptance checks for the spike:

1. launch a Wayland session reliably;
2. display a fullscreen desktop surface;
3. display a bottom dock/panel above normal windows;
4. display a top/center activity surface;
5. support focus, launch, minimize, maximize, and workspace behavior;
6. handle monitor changes and scaling;
7. start and restart the shell without killing the session;
8. document NVIDIA behavior and limitations.

The compositor choice is not final until these checks pass. Avoid writing a custom compositor for the first release.

## 5. Linux base strategy — an open decision

The distribution base remains unselected. Candidates should be compared on:

- stability and update quality;
- availability of Qt 6, Wayland, compiler and GPU-driver packages;
- rollback and recovery options;
- NVIDIA driver support;
- gaming compatibility;
- package maintenance burden;
- ability to produce a reproducible installation image.

openSUSE Tumbleweed is a candidate because it offers a current package set and has ecosystem tooling for snapshots, but it is not selected by this document. A stable base may be preferable if update churn becomes too costly.

Keep the shell buildable on a conventional development Linux environment before packaging it into a distribution.

## 6. Build and code organization

Recommended top-level structure:

```text
NeuaOS/
├── CMakeLists.txt
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── docs/
│   ├── ARCHITECTURE.md
│   ├── ROADMAP.md
│   └── decisions/
├── neua-shell/
│   ├── CMakeLists.txt
│   ├── src/
│   │   ├── app/
│   │   ├── platform/
│   │   ├── models/
│   │   └── services/
│   ├── qml/
│   │   ├── Desktop/
│   │   ├── Dock/
│   │   ├── Island/
│   │   ├── Widgets/
│   │   ├── Launcher/
│   │   ├── Settings/
│   │   └── Components/
│   ├── assets/
│   │   ├── icons/
│   │   ├── fonts/
│   │   ├── wallpapers/
│   │   └── sounds/
│   └── tests/
├── neua-core/
│   ├── interfaces/
│   ├── services/
│   └── tests/
├── neua-apps/
│   ├── launcher/
│   ├── settings/
│   └── file-manager/
├── neua-connect/
│   ├── protocol/
│   ├── linux-client/
│   └── android/
├── packaging/
│   ├── configs/
│   ├── packages/
│   └── image/
└── tools/
```

Use a monorepo initially. Split repositories only if independent release cadence or contributor needs make that worthwhile.

## 7. Engineering conventions

- C++20; use RAII, clear ownership, and avoid unnecessary global state.
- QML files should be small and composed from reusable components.
- Keep platform-specific code behind interfaces.
- Use asynchronous work for I/O and long-running operations; never block the UI thread.
- Add unit tests for models and core logic; add integration tests for shell/platform behavior.
- Keep logs useful and avoid logging personal content or secrets.
- Do not run the desktop shell or ordinary UI as root.
- Treat settings as user data and validate values when loading.
- Use stable, versioned IPC interfaces when crossing process boundaries.

## 8. Performance and quality targets

Do not publish arbitrary RAM or ISO-size promises before measurement. Establish baselines first.

Measure at minimum:

- idle RAM after login, with hardware and services recorded;
- CPU use at idle;
- shell startup time;
- time to first interactive frame;
- animation frame pacing under load;
- wake-up and battery impact on supported laptops;
- installed footprint and ISO size;
- behavior with reduced animations and transparency disabled.

The design must degrade gracefully: users should be able to reduce blur, transparency, and animation for performance or accessibility.

## 9. Updates and recovery

The product requirement is controlled updates with rollback.

Implementation is deferred until the base is chosen. Evaluate:

- Btrfs + Snapper snapshots, if supported and correctly configured;
- image-based or transactional updates, if a suitable base supports them;
- bootloader integration and recovery entry;
- update verification and staged rollout;
- clear separation between OS rollback and user-file backups.

Required tests include interrupted update, failed boot, rollback, and update after rollback. Never imply that a system snapshot protects personal files stored outside the snapshot scope.

## 10. Security and privacy baseline

- no remote-control service enabled by default;
- explicit pairing for Neua Connect;
- encrypted device communication;
- least-privilege service design;
- no shell process running as root;
- signed packages/images when distribution infrastructure is introduced;
- clear update source and integrity checks;
- minimal telemetry; no telemetry by default unless a future decision explicitly changes this.

## 11. Architecture decisions still open

1. Linux base distribution.
2. Wayland compositor and shell-surface integration.
3. Packaging and update/rollback implementation.
4. First-party application scope for Alpha.
5. License and contribution model.
6. Android companion scope and supported device matrix.
