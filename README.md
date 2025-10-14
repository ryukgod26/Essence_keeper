
# Essence Keeper

> A small pixel-art action platformer built in Godot. Fast melee combat, charge attacks, and elemental specials. But I am going to make it Amazing game.

STATUS: Under active development — features, levels and polish are still being added(I am very busy but I will try my best to update the game).

---

## Overview

Essence Keeper is a prototype action-platformer made with Godot 4.x. You play a spellcaster who can run, jump, light-attack, charge heavy attacks, use a flame jet special, and fire ranged projectiles. The project contains example levels, player/enemy scripts, a simple HUD with health bar, and a basic inventory UI for potions and items.

This repository is the development source. Expect bugs, missing audio, and placeholder art while the project is being iterated on.

## Quick facts
- Engine: Godot 4.5
- Main scene: `Scenes/main_menu.tscn`
- Player scripts: `Scripts/fire_player.gd`, `Scripts/wanderer_player.gd`, `Scripts/lightning_player.gd`
- Status: Work in progress — do not treat as a finished release

---

## Gameplay & Features

- Tight 2D platforming movement (run, jump, knockback)
- Melee combat with light and charged heavy attacks (charged attack triggers after ~2s)
- Special abilities: flame jet (close-range), fireball (ranged) (fireball attack is still in development only script is needed to spawn the fireball)
- Enemy AI and very simple damage/health systems for now(Will get updated later)
- HUD with health bar and inventory UI for consumables

## Controls (default)
- Move left / right: MOVE_LEFT / MOVE_RIGHT (A / D or Arrow keys)
- Jump: Jump (Space)
- Light Attack: Attack (mouse button)
- Heavy Attack: Hold Attack to charge, release to perform (held >= 2s)
- Special Attack: Special_attack (Q Key)
- Ranged Attack: Ranged_attack (E Key) (Still in development)
- Toggle Inventory: Inventory (I Key)
- Pause: Pause / Escape



---

## How to run (development)

1. Install Godot 4.5 if you haven't already: https://godotengine.org/download
2. Open the Godot editor and choose `Import` → point to this project's folder or open the folder directly.
3. Open `Scenes/main_menu.tscn` and press Run. 

To play a standalone build, Export the game from your editor for your Platform and then click play.

---

## Project layout (important files)
- `Scenes/` — level scenes, UI scenes, player and enemy scenes
- `Scripts/` — GDScript code for player, enemies, UI and menus
- `assets/` — art and audio assets (some are third-party free assets)
- `addons/` — included plugins (e.g., godot_super-wakatime)

---

## Known issues
- Limited Level Design: I have only created a single level now(Actually I am new to level design and I don't know how to create amazing levels).More Levels will added later

---
