# NeuaOS

> **A system with purpose.**  
> Less noise. More control. A lightweight Linux desktop shaped around the person using it.

NeuaOS is a personal Linux-based desktop operating system project. Its goal is to combine a carefully optimized system base with an original desktop experience: a distinctive monochrome visual language, restrained red accents, useful translucency, and a cohesive set of first-party applications.

The project is currently in the **planning / pre-alpha** stage. The architecture and technology choices below are proposals for the first prototype, not claims that a bootable distribution already exists.

## Project principles

1. **Lightweight by design** — avoid unnecessary services, duplicate background processes, and bundled software. Measure resource use rather than promising arbitrary low numbers.
2. **Purposeful** — every built-in component should have a clear job and a reason to run.
3. **Fluid** — prioritize responsive interaction and consistent motion; visual effects must not compromise usability or performance.
4. **User control** — transparent settings, understandable permissions, and recoverable updates.
5. **Modular** — keep the desktop shell, system services, applications, and distribution packaging separable.
6. **Distinctive, not derivative** — take inspiration from monochrome industrial design and translucent materials without copying another product's branding or interface.

## Product scope

NeuaOS is intended to become a personal desktop distribution for x86_64 PCs. It will use an existing Linux kernel and system base while developing its own shell, visual design system, and selected applications.

### Main components

- **Neua Shell** — desktop surface, dock, Dynamic Island-style activity area, widgets, launcher, and shell settings.
- **Neua Core** — small system services and integration APIs used by the shell.
- **Neua Apps** — first-party applications such as Settings, Launcher, and eventually File Manager.
- **Neua Connect** — optional Android companion and desktop integration.
- **Neua Distribution** — packaging, installation, system defaults, update and rollback workflow.

## Initial technology direction

| Area | Initial direction |
|---|---|
| CPU architecture | x86_64 |
| Kernel | Upstream Linux kernel supplied by the chosen base |
| Display protocol | Wayland |
| UI framework | Qt 6 / Qt Quick / QML |
| Native code | C++20 |
| Build system | CMake |
| IPC | D-Bus where appropriate; typed local APIs where simpler |
| Service manager | systemd on the initial candidate bases |
| Version control | Git |
| Tests | Qt Test plus integration and performance tests |
| System base | Not selected yet; openSUSE is a candidate, not a commitment |

The Wayland compositor/window-management integration is an explicit technical investigation. A Qt/QML shell is not itself a compositor. The first prototype will validate the desktop surfaces, panels, input behavior, and session startup before the compositor is locked in.

## Update philosophy

NeuaOS will favor **controlled updates with a recovery path** over unreviewed changes:

- Updates should be discoverable and understandable.
- The user should be able to review what is changing.
- A known-good system state should be recoverable where the selected base supports it.
- Rollback behavior must be tested, documented, and clearly distinguish system rollback from personal-file backups.
- Updates should be staged and validated before becoming the default path.

Btrfs/Snapper or an image-based update model may be evaluated after choosing the base. A filesystem snapshot alone is not a complete backup of personal data.

## Current status

**Planning / pre-alpha.** No stable release, installer, or complete desktop environment exists yet.

### First milestone

Build a runnable Neua Shell prototype that demonstrates:

- desktop background and clock;
- a translucent bottom dock;
- a compact Dynamic Island-style activity surface;
- a small set of widgets;
- a basic settings panel for theme and effects;
- graceful behavior when optional services are unavailable.

## Repository map

```text
NeuaOS/
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── CMakeLists.txt
├── docs/
│   ├── ARCHITECTURE.md
│   ├── ROADMAP.md
│   └── decisions/
├── neua-shell/
│   ├── CMakeLists.txt
│   ├── src/
│   ├── qml/
│   ├── assets/
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

Directories will be added when their first real implementation lands; avoid committing empty placeholder trees.

## Non-goals for the first alpha

- Writing a custom Linux kernel.
- Writing a new Wayland compositor.
- Supporting every desktop environment or every GPU at launch.
- Promising compatibility with every Android/Nothing phone model before testing.
- Replacing the package manager of the chosen base prematurely.
- Shipping effects that consume resources without improving the experience.

## Contributing and development

The project should favor small, reviewable changes. Keep architecture decisions in `docs/decisions/`, add tests for behavior that can break, and record performance measurements with hardware and test conditions.

Before a base distribution is selected, keep the shell as portable as practical and avoid hard-coding distribution-specific paths or package-management commands.

## Name and identity

**NeuaOS** is the working project name. The visual direction combines monochrome geometry, dot-based details, restrained red accents, and selective Liquid Glass-inspired surfaces. The design must remain original and accessible: translucency should always preserve contrast and readability.

## License

NeuaOS is licensed under the GNU General Public License v3.0 or later.
See [LICENSE](LICENSE) for the full text.