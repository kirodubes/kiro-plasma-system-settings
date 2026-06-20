# CLAUDE.md — kiro-plasma-system-settings

## Project overview

See [README.md](./README.md) for the user-facing description. This repo ships the
default **KDE Plasma System Settings** configuration applied to every new user on
Kiro's Plasma edition.

## Current state

Created 2026-06-20. Standard Kiro bash scaffold (`up.sh`, `setup.sh`) plus the
three required markdown files. `etc/skel/.config/` ships four **minimal**
behavioural-default files, captured live from a Plasma box with
`capture-plasma-config.sh`: `kscreenlockerrc` (lock disabled), `ksmserverrc`
(no logout confirm + empty session), `kwinrc` (bottom-left hot corner → Show
Desktop), `powerdevilrc` (display/suspend timeouts). Theme/colour-scheme config
is intentionally out of scope (different project). Each file carries only the
changed keys so all other Plasma defaults still fall back to KDE's own.

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

- Add the build recipe under the matching `~/KIRO-PKG-BUILD-*` parent so it ships
  a `kiro-plasma-system-settings` package (copies `etc/` into the package).
- Capture more behavioural defaults as they surface (re-run
  `capture-plasma-config.sh` snapshot → change → diff).

Open work for the whole ecosystem lives in
[HQ/MASTER_TODO.md](/home/erik/Insync/Kiro/Kiro-HQ/MASTER_TODO.md) — there is no
per-repo TODO.md.
