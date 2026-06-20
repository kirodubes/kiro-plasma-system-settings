# Changelog

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
