# Godot2Blender Ctl

Blender-style editor controls for Godot 4.7+, packaged as one addon.

If your hands know Blender, this makes the Godot 3D editor behave the way you
expect: `G`/`R`/`S` modal transforms with axis constraints, `Z` for a
debug-draw pie menu, `[` / `]` radial menus for camera and viewport, and
Blender-like select / deselect / select-children commands.

## What's inside

One plugin, three modules, one enable switch:

| Module | What it does | Upstream |
|---|---|---|
| `modules/transform` | `G`/`R`/`S` modal transform, `X`/`Y`/`Z` axis constraints, numeric input, `Z` debug-draw pie menu | [gd-blender-3d-shortcuts](https://github.com/imjp94/gd-blender-3d-shortcuts) (MIT) |
| `modules/viewport` | `[` / `]` radial menus for viewport and camera controls | [blender-viewport-shortcuts](https://github.com/mineland-2048/blender-viewport-shortcuts) (LGPL-3.0) |
| `modules/selection` | Select all / none, children, by name, by type, invert | [Selection-Tools-Godot](https://github.com/xtremezero/Selection-Tools-Godot) (MIT) |

`plugin.gd` is the master plugin. It instantiates the three modules as child
`EditorPlugin` nodes and forwards the four callbacks that only a *registered*
plugin receives — `_handles`, `_edit`, `_forward_3d_gui_input`,
`_forward_3d_draw_over_viewport`. `_ready`, `_input` and `_enter_tree` fire on
children normally and need no forwarding.

## Install

Copy `addons/godot2Blender_Ctl/` into your project's `addons/` directory, then
enable **Godot2Blender Ctl** in *Project → Project Settings → Plugins*.

Requires Godot 4.7 or newer. Developed and verified against 4.7.2.

## Changes from upstream

- Paths rewritten from three separate addon roots into one tree.
- `preload("uid://…")` replaced with explicit `res://` paths. A uid only
  resolves while the project's uid cache still maps it, and that cache does not
  survive a folder rename or a fresh clone — this broke on the first rename.
- The nested `extra-controls` plugin (a second `plugin.cfg` enabled through
  `EditorInterface.set_plugin_enabled`) is dropped; modules are plain children
  now, so `_enable_plugin` never fires for them.
- `main_screen` lookup in the viewport module guards against a missing 3D
  editor screen instead of indexing into `get_child(-1)`.

## License

**GPL-3.0-or-later.** This is a combined work: the viewport module is
LGPL-3.0 and the selection module ships GPL-3.0, so the package as a whole must
be GPL-3.0. The transform module is MIT and remains compatible.

Upstream copyright notices are retained in each module. See
[THIRD_PARTY.md](THIRD_PARTY.md).

This is a personal convenience tool, not a product. No warranty.
