# Changelog

## 2026.06.23 (later) — Switch the default to `/etc/skel/.config/kdeglobals` (xdg cascade doesn't apply colours)

### What Changed
- Replaced `etc/xdg/kdeglobals` with **`etc/skel/.config/kdeglobals`**. Verified on a live VM:
  the `/etc/xdg` cascade is **not** honoured by the running Plasma session/apps for the colour
  scheme — `kreadconfig6` reads it, but Dolphin/QWidget apps render Breeze regardless. Colours
  only take effect when they live in the user's own `~/.config/kdeglobals`, which `/etc/skel`
  seeds for every new account (installed + live-ISO user).
- The shipped file is the **captured Kiro-Nordic default** dialed in on the test box: light app
  colours (Breeze-style, white View) + `widgetStyle=Breeze` + `LookAndFeelPackage=Kiro-Nordic`
  (dark shell / panel / Aurorae titlebar). Net look: light apps, dark Kiro-Nordic chrome.
- `depends=('kiro-plasma-nord')` retained (the default references the Kiro-Nordic look-and-feel).

### Technical Details
- This supersedes the earlier same-day `/etc/xdg/kdeglobals` entry below — that approach was
  config-reader-correct but did not actually paint apps. `/etc/skel` is the working delivery.
- GTK defaults are intentionally NOT here (handled separately via ATT). Window decoration
  (kwinrc) stays with `kiro-plasma-window-management`.

## 2026.06.23 — Own the default theme/colour selector (`/etc/xdg/kdeglobals`)

### What Changed
- This package now ships **`etc/xdg/kdeglobals`**, the single system-wide default-theme
  selector: `[KDE]LookAndFeelPackage=Kiro-Nordic` + `[General]ColorScheme=Kiro-Nordic` plus the
  full Nordic `[Colors:*]` sections. So a fresh Kiro Plasma install boots with the **Kiro-Nordic**
  global theme and colours by default.
- Centralising it here is deliberate: KIB installs **all** theme packages onto one system, so
  the default selector cannot live in a theme package — two themes shipping `/etc/xdg/kdeglobals`
  would be a pacman file conflict. Previously `kiro-plasma-sweet` owned this file (making Sweet
  the de-facto default); that file is being removed from Sweet (and from Nord) so this package is
  the sole owner. Each theme package now ships only its uniquely-named assets.
- Added `depends=('kiro-plasma-nord')` since the selector points at the Kiro-Nordic theme/scheme.

### Technical Details
- Plasma's Global-Theme apply does not apply a look-and-feel's colour scheme (colours are treated
  as a user personalisation), so the colours must be seeded as a cascade default — this file is
  read beneath `~/.config` and applies to every user incl. the live-ISO user. Changing the default
  theme later is now a one-file edit here.
- Scope note: theme/colour config was previously out of scope for this package; that changed with
  this commit by design (single-owner requirement under KIB).

## 2026.06.20 (kwinrc moved out)

### What Changed
- Removed `etc/xdg/kwinrc` (the `[ElectricBorders] BottomLeft=ShowDesktop` key). All
  KWin config now lives in `kiro-plasma-window-management`, so only one package owns
  `/etc/xdg/kwinrc` (avoids a pacman file conflict). This package now ships four files.

### Files Modified
- etc/xdg/kwinrc (removed → moved to kiro-plasma-window-management)
- CLAUDE.md (five → four files; kwinrc relocation noted)

## 2026.06.20 (NumLock on at login)

### What Changed
- Added `etc/xdg/kcminputrc` so NumLock is turned **on** at login for all users.
  Captured live from riker (`~/.config/kcminputrc` → `[Keyboard] NumLock=0`,
  where `0` = turn on). Minimal file — only the changed key.

### Files Modified
- etc/xdg/kcminputrc (new)
- CLAUDE.md (file count four → five; kcminputrc noted)

## 2026.06.20 (delivery → /etc/xdg)

### What Changed
- Moved the payload from `etc/skel/.config/` to `etc/xdg/`. Skel only seeds
  newly-created accounts and risks file-ownership conflicts; `/etc/xdg/` is KDE's
  XDG cascade default layer — applies to **all** users, is never overwritten
  (the user's `~/.config` always wins), and is cleanly revertable on uninstall.
- Verified on a Plasma 6 box that all four files are honored by the cascade
  (`kreadconfig6` sentinel read-through test — all PASS) before switching.
- README/CLAUDE updated: install is now `sudo cp -rT etc /etc` (lands in
  `/etc/xdg/`); no per-home copying needed.

### Files Modified
- etc/skel/.config/{kscreenlockerrc,ksmserverrc,kwinrc,powerdevilrc} → etc/xdg/ (moved)
- README.md, CLAUDE.md (delivery model rewritten)

## 2026.06.20 (payload)

### What Changed
- First real payload baked into `etc/skel/.config/` — captured live from a Plasma
  box via `capture-plasma-config.sh` (snapshot → change settings → diff), keeping
  only the non-theme behavioural keys. Theme/colour-scheme changes were
  deliberately excluded (different project).
- Each file is **minimal** — only the changed keys, so every other Plasma default
  still falls back to KDE's own.

### Settings shipped
- `kscreenlockerrc` — screen lock disabled (`Autolock`/`LockOnResume`=false, `Timeout`=0).
- `ksmserverrc` — `confirmLogout`=false, `loginMode`=emptySession (clean session each login).
- `kwinrc` — bottom-left hot corner → Show Desktop (`[ElectricBorders] BottomLeft=ShowDesktop`).
- `powerdevilrc` — display off at 15 min, suspend at 30 min, `PowerButtonAction`=8 (AC profile).

### Deliberately not shipped
- `krdpserverrc` — per-machine RDP cert paths with a hardcoded home path (not portable).
- `kglobalshortcutsrc` — only a KDE-rewritten friendly-name label, no real key change.

### Files Modified
- etc/skel/.config/{kscreenlockerrc,ksmserverrc,kwinrc,powerdevilrc} (created)
- etc/skel/.config/.gitkeep (removed — real payload now present)

## 2026.06.20

### What Changed
- Initial repo created in the Kiro ecosystem: default KDE Plasma System Settings
  configuration for the Plasma edition.
- Standard markdown scaffold added (`README.md`, `CHANGELOG.md`, `CLAUDE.md`) per
  the ecosystem MD-scaffold rule.
- Canonical bash scaffold copied in (`up.sh`, `setup.sh`) plus `LICENSE`,
  `kiro.jpg`, `.gitignore`.
- Empty payload directory `etc/skel/.config/` created as a placeholder for the
  Plasma config files still to be added.
- Added `capture-plasma-config.sh` — a maintainer helper (not shipped) that
  snapshots `~/.config/*rc` before/after a System Settings session and prints
  exactly which file/group/key changed, so only those keys get baked into skel.
- Git initialised with the kirodubes SSH remote; repo created on GitHub.

### Technical Details
- Modelled on the sibling `kiro-plasma-servicemenus` repo (same `etc/skel/`
  ship-via-`/etc/skel/` pattern).
- `setup.sh` auto-detects the `~/KIRO/` path and sets the Kiro Dubes identity and
  the kirodubes SSH remote.

### Files Modified
- README.md (created)
- CHANGELOG.md (created)
- CLAUDE.md (created)
- up.sh, setup.sh, LICENSE, kiro.jpg, .gitignore (copied)
- etc/skel/.config/.gitkeep (created)
