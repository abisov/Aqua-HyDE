# Upstream Sync History

This file tracks synchronization with the [HyDE upstream repository](https://github.com/HyDE-Project/HyDE).

---

## 2026-02-23 — Sync from upstream/dev

**Upstream Commit Range:** `7493044f` (Dec 8, 2025) → `686acb6e` (Feb 2026)

### Phase 1: Critical Bug Fixes

| Change | File | Description |
|--------|------|-------------|
| Keybindings migration | `keybindings.conf` | All `$scrPath/script.sh` → `hyde-shell <cmd>` pattern |
| FONT_SIZE fix | `theme.switch.sh` | Type cast `[int]` for font size variables in hyq queries |
| Lockscreen init order | `lockscreen.sh` | Fixed variable precedence: HYPRLAND_LOCKSCREEN → LOCKSCREEN → HYDE_LOCKSCREEN |
| NVIDIA cursor config | `nvidia.conf` | Updated `cursor:allow_dumb_copy` → `cursor:use_cpu_buffer` |
| Fastfetch logo | `fastfetch/config.jsonc` | Uses `hyde-shell fastfetch logo` for proper script resolution |
| Python venv fix | `pip_env.py`, `xdg_base_dirs.py` | Added `is_venv_valid()` + auto-rebuild on Python version change |
| Variables update | `variables.conf` | `hyde-shell open` for apps, `blueman-applet` for bluetooth, removed hardcoded `$FONT_STYLE` |
| Qt color path | `qt5ct/`, `qt6ct/` | Moved from `colors.conf` → `colors/wallbash.conf` with new wallbash script |

### Phase 2: Feature Syncs

| Feature | Files | Description |
|---------|-------|-------------|
| Window rules v0.53 | `windowrules.conf` | Block syntax with named rules, PiP `match:title`, Steam floating, dolphin popup-only |
| Waybar styling | `waybar/*.css` | Fade animations for menus/tooltips, border-radius, tray checkbox/radio shapes |
| CPU/GPU CSS classes | `waybar/styles/classes/` | Temperature-based color buckets (`temp-0` through `temp-100`) |
| SwayNC wallbash | `swaync/`, `wallbash/` | Notification center theming with wallbash colors |
| Gamelauncher search | `gamelauncher_5.rasi` | Input bar with "Start typing to search..." placeholder |
| Weather locale | `weather.py` | Auto-detect user locale for language, units (c/f), time format |
| System scripts | `system.monitor.sh`, `system.update.sh` | New scripts for waybar widgets |
| Hyprlock MPRIS | `hyprlock.conf` | Fixed scope type for MPRIS commands |
| UwSM env | `uwsm/env` | Added `APP2UNIT_TYPE="service"` default |

### Phase 3: Preserved Customizations

The following custom additions were preserved during this sync:

| Customization | Location |
|---------------|----------|
| Powerlevel10k theme | `pkg_extra.lst`, `zsh/conf.d/hyde/prompt.zsh` |
| Lazygit alias | `zsh/functions/lazygit.zsh` |
| Tmux + sesh | `pkg_extra.lst`, `.config/tmux/` |
| Docker | `pkg_core.lst` |
| FNM (Node version manager) | `pkg_extra.lst`, `zsh/conf.d/fnm.zsh` |
| Neovim | `pkg_extra.lst`, `restore_cfg.psv` |
| Posting (HTTP TUI) | `pkg_extra.lst`, `restore_cfg.psv` |
| Rainfrog (Postgres TUI) | `pkg_extra.lst` |
| Zen Browser | `pkg_extra.lst` |
| Bluetooth scripts | `.local/bin/hyde-launch-bluetooth`, `hyde-restart-bluetooth` |
| Lid handler (clamshell) | `.local/bin/lid-handler.sh` |
| Monitor handler (hotplug) | `.local/bin/monitor-handler.sh` |

### Files Modified (28)

```
Configs/.config/fastfetch/config.jsonc
Configs/.config/hypr/keybindings.conf
Configs/.config/hypr/nvidia.conf
Configs/.config/hypr/windowrules.conf
Configs/.config/qt5ct/qt5ct.conf
Configs/.config/qt6ct/qt6ct.conf
Configs/.config/uwsm/env
Configs/.config/waybar/includes/border-radius.css
Configs/.local/lib/hyde/cpuinfo.sh
Configs/.local/lib/hyde/gpuinfo.sh
Configs/.local/lib/hyde/lockscreen.sh
Configs/.local/lib/hyde/pyutils/pip_env.py
Configs/.local/lib/hyde/pyutils/xdg_base_dirs.py
Configs/.local/lib/hyde/theme.switch.sh
Configs/.local/lib/hyde/weather.py
Configs/.local/share/hyde/hyprlock.conf
Configs/.local/share/hyde/rofi/themes/gamelauncher_5.rasi
Configs/.local/share/hyde/rofi/themes/steam_deck.rasi
Configs/.local/share/hypr/dynamic.conf
Configs/.local/share/hypr/variables.conf
Configs/.local/share/hypr/windowrules.conf
Configs/.local/share/wallbash/always/qtct.dcol
Configs/.local/share/waybar/includes/border-radius.css
Configs/.local/share/waybar/modules/temperature.jsonc
Configs/.local/share/waybar/styles/defaults.css
```

### Files Added (13)

```
Configs/.config/qt5ct/colors/wallbash.conf
Configs/.config/qt6ct/colors/wallbash.conf
Configs/.config/swaync/config.json
Configs/.config/swaync/style.css
Configs/.config/swaync/user-style.css
Configs/.local/bin/lid-handler.sh
Configs/.local/bin/monitor-handler.sh
Configs/.local/lib/hyde/system.monitor.sh
Configs/.local/lib/hyde/system.update.sh
Configs/.local/share/hyde/wallbash/scripts/swaync.sh
Configs/.local/share/hyde/wallbash/theme/swaync.dcol
Configs/.local/share/wallbash/scripts/qtct.sh
Configs/.local/share/waybar/styles/classes/cpuinfo.css
Configs/.local/share/waybar/styles/classes/gpuinfo.css
```

---

## How to Apply Changes

### Official Method (Recommended)

```bash
cd ~/HyDE
git pull origin master
./Scripts/install.sh -r
```

This will restore all configs from the repo to your home directory.
- Backs up existing configs to `~/.config/cfg_backups`
- Only restores configs for packages you have installed

### Manual Selective Copy

If you only want specific configs:

```bash
# Hypr configs
cp -r Configs/.config/hypr ~/.config/
cp -r Configs/.local/share/hypr ~/.local/share/
cp -r Configs/.local/lib/hyde ~/.local/lib/

# Waybar
cp -r Configs/.config/waybar ~/.config/
cp -r Configs/.local/share/waybar ~/.local/share/

# SwayNC (new)
cp -r Configs/.config/swaync ~/.config/

# Wallbash scripts
cp -r Configs/.local/share/wallbash ~/.local/share/

# Custom scripts
cp Configs/.local/bin/lid-handler.sh ~/.local/bin/
cp Configs/.local/bin/monitor-handler.sh ~/.local/bin/
```

### Post-Sync Actions

1. **Reload Hyprland:** `Super + Shift + R` or `hyprctl reload`
2. **Restart Waybar:** `pkill waybar; waybar &`
3. **Rebuild Python venv** (if needed): `hyde-shell pip rebuild`
4. **Refresh wallbash:** `hyde-shell wallbash`

---

*Last synced: 2026-02-23*
