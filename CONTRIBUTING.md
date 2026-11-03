# Contributing to NeuaOS

Thanks for your interest. NeuaOS is in the planning / pre-alpha stage,
so expect the architecture to evolve.

## Before you start

- Read `README.md` for project principles and scope.
- Read `docs/ARCHITECTURE.md` for the technical direction.
- Check `docs/decisions/` for open architectural decisions.
- For non-trivial changes, open an issue or discussion first.

## Development setup

Required:

- CMake 3.16 or newer
- A C++20 compiler (GCC 13+ or Clang 16+ recommended)
- Qt 6.8 or newer (Quick module)
- A Linux system with a Wayland session for shell development

Build (once the shell skeleton lands):

    cmake -B build
    cmake --build build

## Pull requests

- Keep changes small and reviewable; one logical change per PR.
- Fill the PR template.
- Add tests for behavior that can break.
- Update documentation when behavior or architecture changes.
- Do not run the desktop shell or ordinary UI as root.

## Commit messages

Use short, imperative subjects:

    shell: add translucent dock surface
    docs: add ADR for update model
    build: pin Qt 6.8 in CMakeLists

## License

By contributing, you agree that your contributions are licensed under
the GNU General Public License v3.0 or later. See `LICENSE`.