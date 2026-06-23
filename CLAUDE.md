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
session), `powerdevilrc` (display/suspend timeouts), `kcminputrc` (NumLock on at
login). Each file carries only the changed keys so all other Plasma defaults
still fall back to KDE's own.

**Default theme/colour selector (2026-06-23):** this package now also owns
`etc/xdg/kdeglobals`, the single system-wide default-theme selector
(`[KDE]LookAndFeelPackage=Kiro-Nordic` + `[General]ColorScheme=Kiro-Nordic` + the
full Nordic `[Colors:*]`). It must live in exactly one always-installed package
because KIB installs **all** theme packages together — two themes shipping
`/etc/xdg/kdeglobals` would be a pacman file conflict. Previously
`kiro-plasma-sweet` owned it (de-facto default = Sweet); it was moved here and
removed from Sweet + Nord. `depends=('kiro-plasma-nord')` because the selector
points at that theme. Change the default theme by editing this one file.

**`kwinrc` is NOT here** — all KWin config (including the `[ElectricBorders]` key
that used to live here) was moved to `kiro-plasma-window-management` (2026-06-20) so
only one package owns `/etc/xdg/kwinrc`.

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
