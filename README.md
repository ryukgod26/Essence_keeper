
# Magic Game (WIP)

> A small pixel-art action platformer built in Godot. Fast melee combat, charge attacks, and elemental specials.

STATUS: Under active development — features, levels and polish are still being added.

---

## Overview

Magic Game is a prototype action-platformer made with Godot 4.x. You play a spellcaster who can run, jump, light-attack, charge heavy attacks, use a flame jet special, and fire ranged projectiles. The project contains example levels, player/enemy scripts, a simple HUD with health bar, and a basic inventory UI for potions and items.

This repository is the development source. Expect bugs, missing audio, and placeholder art while the project is being iterated on.

## Quick facts
- Engine: Godot 4.x (project file config_version=5)
- Main scenes: `Scenes/main_menu.tscn`, `Scenes/level_selector.tscn`, `Scenes/level1.tscn`
- Player scripts: `Scripts/fire_player.gd`, `Scripts/wanderer_player.gd`, `Scripts/lightning_player.gd`
- Status: Work in progress — do not treat as a finished release

---

## Gameplay & Features

- Tight 2D platforming movement (run, jump, knockback)
- Melee combat with light and charged heavy attacks (charged attack triggers after ~2s)
- Special abilities: flame jet (close-range), fireball (ranged)
- Enemy AI and simple damage/health systems
- HUD with health bar and inventory UI for consumables
- Tile-based levels using free pixel forest assets (included under their original licenses)

## Controls (default)
- Move left / right: MOVE_LEFT / MOVE_RIGHT (A / D or Arrow keys)
- Jump: Jump (Space)
- Light Attack: Attack (mouse button / key)
- Heavy Attack: Hold Attack to charge, release to perform (held >= ~2s)
- Special Attack: Special_attack (default Q)
- Ranged Attack: Ranged_attack (default E)
- Toggle Inventory: Inventory (default I)
- Pause: Pause / Escape

Input actions are configurable in `project.godot` under the `[input]` section.

---

## How to run (development)

1. Install Godot 4.x if you haven't already: https://godotengine.org/download
2. Open the Godot editor and choose `Import` → point to this project's folder (where `project.godot` is located), or open the folder directly.
3. Open `Scenes/main_menu.tscn` and press Run. You can also run `Scenes/level1.tscn` directly for quick testing.

To play a standalone build, create an exported project for your platform from Godot's export templates.

---

## Project layout (important files)
- `Scenes/` — level scenes, UI scenes, player and enemy scenes
- `Scripts/` — GDScript code for player, enemies, UI and menus
- `assets/` — art and audio assets (some are third-party free assets)
- `addons/` — included plugins (e.g., godot_super-wakatime)

---

## Known issues & notes
- Prototype state: missing polish, missing or placeholder sounds, balance and tuning required.
- Some asset folders may be large. If you plan to publish the repository or upload to itch.io, consider using Git LFS for large binaries or exclude them from source bundles.

---

## Contributing

Contributions are welcome! If you'd like to help:

1. Fork the repository and make feature branches for your work.
2. Keep changes small and focused (e.g., `feature/new-enemy`, `fix/attack-bug`).
3. Open a pull request describing the change and any testing steps.

Please note: because this project is under development, breaking changes may occur on the `master` branch.

---

## Credits & Licenses

- Game code and project: (your name or handle) — replace with your preferred credit
- Art: Free Pixel Art Forest and other free assets included in `assets/` — check the original asset licenses in the `assets/` folders
- Inventory UI sprites: included in `assets/Inventory/`
- Tools: Godot Engine, optional plugin `addons/godot_super-wakatime`

This project is distributed under the MIT License. See `LICENSE` for details.

---

## Packaging for itch.io (developer notes)

- If you upload source to itch.io, consider including a small `UPLOAD.md` explaining which folders to include (e.g., `Scenes/`, `Scripts/`, `assets/` if desired).
- If you want to publish game builds rather than the full source, export platform-specific builds from Godot and upload those instead.

---

If you want, I can also:

- generate an `UPLOAD.md` with packaging steps for itch.io,
- add a `.gitattributes` recommending Git LFS for large images (PNGs/JPGs) and a tuned `.gitignore`, or
- prepare a short release notes template for your jam/public release.

