<p align="center">
  <img src="kiro.jpg" alt="Kiro" width="220" />
</p>

# kiro-plasma-system-settings

Default **KDE Plasma System Settings** configuration for Kiro — the out-of-the-box
look-and-feel and behaviour applied to every new user on the Plasma edition
(theme, fonts, workspace behaviour, and other System Settings defaults). Sibling
to [kiro-plasma-keybindings](https://github.com/kirodubes/kiro-plasma-keybindings)
and [kiro-plasma-servicemenus](https://github.com/kirodubes/kiro-plasma-servicemenus).

## What's in this repo

- `etc/xdg/` — Plasma configuration files shipped as **system-wide XDG defaults**.
  KDE reads `/etc/xdg/<file>` as a lower-priority layer *beneath* each user's
  `~/.config/`, so these defaults apply to **every** user (existing and new),
  are **never** written over (a user's own change is saved to their home and
  always wins), and are cleanly removed when the package is uninstalled.
  - `kwinrc` — bottom-left hot corner → Show Desktop.
  - `kscreenlockerrc` — screen lock disabled.
  - `ksmserverrc` — no logout confirmation; start each session clean.
  - `powerdevilrc` — display/suspend idle timeouts (AC profile).
- `capture-plasma-config.sh` — maintainer helper (not shipped) to capture more
  defaults: snapshot `~/.config`, change settings, diff for the exact keys.
- `setup.sh`, `up.sh` — standard Kiro bash scaffold (git identity + sync).

## Installation

### From `nemesis_repo` (recommended)

```ini
[nemesis_repo]
SigLevel = Never
Server = https://erikdubois.github.io/$repo/$arch
```

```bash
sudo pacman -Syu
sudo pacman -S kiro-plasma-system-settings
```

### Manual

```bash
git clone https://github.com/kirodubes/kiro-plasma-system-settings.git
cd kiro-plasma-system-settings
sudo cp -rT etc /etc
```

The files land in `/etc/xdg/`. Because that is the XDG default layer, the
settings apply to every user automatically — no copying into individual home
directories. Log out and back in (or restart Plasma) for them to take effect.
To remove them, delete the shipped files from `/etc/xdg/` (or uninstall the
package); each user's own customisations in `~/.config/` are untouched.

## Websites

Information : https://kiroproject.be

## Social Media

Youtube : https://www.youtube.com/erikdubois

<!-- KIRO-FUNDING-FOOTER:START — managed by Kiro-HQ/cascade-readme-footer.sh -->
## Help fund Kiro

Everything I build here stays free and open — always. If Kiro or any of these
tools have ever saved you time or taught you something, a small monthly
contribution helps keep the work going. Donations target break-even, nothing
more — the core always stays free for everyone.

- GitHub Sponsors: https://github.com/sponsors/erikdubois
- Patreon: https://www.patreon.com/c/kiroproject
- YouTube memberships: https://www.youtube.com/@ErikDubois/join
- Ko-fi: https://ko-fi.com/erikdubois
- PayPal: https://www.paypal.me/erikdubois
<!-- KIRO-FUNDING-FOOTER:END -->

## License

See [LICENSE](./LICENSE).
