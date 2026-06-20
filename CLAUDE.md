# CLAUDE.md — kiro-plasma-system-settings

## Project overview

See [README.md](./README.md) for the user-facing description. This repo ships the
default **KDE Plasma System Settings** configuration applied to every new user on
Kiro's Plasma edition.

## Current state

Created 2026-06-20. Standard Kiro bash scaffold (`up.sh`, `setup.sh`) plus the
three required markdown files. `etc/xdg/` ships four **minimal** behavioural-default
files, captured live from a Plasma box with `capture-plasma-config.sh`:
`kscreenlockerrc` (lock disabled), `ksmserverrc` (no logout confirm + empty
session), `kwinrc` (bottom-left hot corner → Show Desktop), `powerdevilrc`
(display/suspend timeouts). Theme/colour-scheme config is intentionally out of
scope (different project). Each file carries only the changed keys so all other
Plasma defaults still fall back to KDE's own.

### Why `/etc/xdg/`, not `/etc/skel/.config/`

`/etc/xdg/<file>` is KDE's XDG **cascade** default layer — read *beneath* each
user's `~/.config/`. Chosen over skel because it applies to **all** users (not
just freshly created accounts), is **never** overwritten (the user's own change
saves to their home and always wins), and is cleanly revertable on uninstall.
Verified on a Plasma 6 box (2026-06-20) that all four files are honored by the
cascade via `kreadconfig6` (sentinel-group read-through test). Note: the cascade
does **not** reliably cover global shortcuts — that is why the sibling
`kiro-plasma-keybindings` still seeds its `kglobalshortcutsrc` via `/etc/skel`.

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

- Capture more behavioural defaults as they surface (re-run
  `capture-plasma-config.sh` snapshot → change → diff).

## Packaging

The build recipe lives at
[`~/KIRO-PKG-BUILD-APPS/kiro-plasma-system-settings/`](/home/erik/KIRO-PKG-BUILD-APPS/kiro-plasma-system-settings/PKGBUILD)
— git+ source, ships `etc/` (i.e. `/etc/xdg/*`) into the package, license under
`/usr/share/kiro/licenses/`. Built into `nemesis_repo` by Erik's build flow.

Open work for the whole ecosystem lives in
[HQ/MASTER_TODO.md](/home/erik/Insync/Kiro/Kiro-HQ/MASTER_TODO.md) — there is no
per-repo TODO.md.
