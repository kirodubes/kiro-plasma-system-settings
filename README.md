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

- `etc/skel/.config/` — Plasma configuration files (`kdeglobals`, `kwinrc`,
  `plasmarc`, KCM defaults, …) that land in a new user's `~/.config/` via
  `/etc/skel/`. Currently a scaffold — drop the shipped config files in here.
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
sudo cp -rT etc/skel /etc/skel
```

Existing users can copy the defaults straight into their own home:

```bash
cp -rT /etc/skel ~/
```

Log out and back in (or restart Plasma) for the new System Settings defaults to
take effect.

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
