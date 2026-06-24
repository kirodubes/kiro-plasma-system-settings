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

**Default theme (2026-06-23):** this package owns
`etc/skel/.config/kdeglobals`, the captured default user appearance
(`[KDE]LookAndFeelPackage=Kiro-Nordic` + `widgetStyle=Breeze` + the `[Colors:*]`
the default renders with — light apps, dark Kiro-Nordic shell). It is shipped via
**`/etc/skel`**, NOT `/etc/xdg`: verified on a live VM that the `/etc/xdg`
cascade is ignored by the running session for the colour scheme (kreadconfig6
reads it, but apps render Breeze). Colours only apply from the user's own
`~/.config/kdeglobals`, which skel seeds for every new account. Single-owner
because KIB installs all theme packages together. `depends=('kiro-plasma-nord')`
(the default references that look-and-feel). To change the default look: dial it
in on a test box, capture `~/.config/kdeglobals`, drop it here. GTK is handled by
ATT; window decoration by `kiro-plasma-window-management`.

**`/etc/xdg/kwinrc` is NOT here** — all behavioural KWin config (including the
`[ElectricBorders]` key that used to live here) was moved to
`kiro-plasma-window-management` (2026-06-20) so only one package owns
`/etc/xdg/kwinrc`. **Exception (2026-06-24):** this package ships
`etc/skel/.config/kwinrc` with `[Wayland] FollowLocale1=true` — a *different path*
(skel, not xdg), no file conflict. Kiro Plasma is Wayland-only; this makes KWin
follow the installer-chosen keyboard layout (otherwise it falls back to `us`). It
lives here, not in window-management, because — like `kdeglobals` — the live session
does not honour `/etc/xdg/kwinrc` for this; the key must be in the user's own
`~/.config/kwinrc`, which skel seeds. **Paired with** the `XKBLAYOUT=` write in
`kiro-calamares-config(-next)`'s `kiro_final` module — both halves are required.

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
