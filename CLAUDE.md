# CLAUDE.md — kiro-plasma-system-settings

## Project overview

See [README.md](./README.md) for the user-facing description. This repo ships the
default **KDE Plasma System Settings** configuration applied to every new user on
Kiro's Plasma edition.

## Current state

Scaffold created 2026-06-20. Standard Kiro bash scaffold (`up.sh`, `setup.sh`)
plus the three required markdown files. The payload directory
`etc/skel/.config/` is an empty placeholder — the actual Plasma config files
(`kdeglobals`, `kwinrc`, `plasmarc`, KCM defaults, …) are still to be added.

## Patterns & decisions

- Bash scripts follow the canonical template from Kiro-HQ — see the canonical
  [up.sh](/home/erik/Insync/Kiro/Kiro-HQ/up.sh) /
  [setup.sh](/home/erik/Insync/Kiro/Kiro-HQ/setup.sh).
- `setup.sh` is path-aware: under `~/KIRO/` it sets the **Kiro Dubes** identity
  and the `git@github.com-kiro:kirodubes/<repo>` remote automatically.
- Config ships via `/etc/skel/` so it applies to newly created users only —
  existing users are never overwritten.
- Sibling repos: [kiro-plasma-keybindings](https://github.com/kirodubes/kiro-plasma-keybindings),
  [kiro-plasma-servicemenus](https://github.com/kirodubes/kiro-plasma-servicemenus).

## Next steps

- Populate `etc/skel/.config/` with the real Plasma System Settings defaults.
- Add the build recipe under the matching `~/KIRO-PKG-BUILD-*` parent once the
  package is ready.

Open work for the whole ecosystem lives in
[HQ/MASTER_TODO.md](/home/erik/Insync/Kiro/Kiro-HQ/MASTER_TODO.md) — there is no
per-repo TODO.md.
