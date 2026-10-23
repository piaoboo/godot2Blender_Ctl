# Third-party notices

This addon combines three upstream Godot editor addons. Each module keeps its
original copyright notice and license file.

## modules/transform

- **Source:** https://github.com/imjp94/gd-blender-3d-shortcuts
- **Version used:** 0.4.0
- **License:** MIT — Copyright (c) 2021 Tan Jian Ping
- **Changes:** paths rewritten into the merged tree; `preload` uid replaced with
  explicit paths (in the master plugin, not in this module).

## modules/viewport

- **Source:** https://github.com/mineland-2048/blender-viewport-shortcuts
- **Version used:** 1.0
- **License:** LGPL-3.0-or-later — Copyright (c) 2026 mineland
- **Changes:** paths rewritten; `uid://` preloads replaced with explicit
  `res://` paths; nested `extra-controls` plugin removed; `_enable_plugin` /
  `_disable_plugin` merged into `_enter_tree` (module is a child node, so the
  enable hook never fires); missing-3D-screen guard added.

## modules/selection

- **Source:** https://github.com/xtremezero/Selection-Tools-Godot
- **Version used:** 1.0
- **License:** the repository root declares MIT, while the copy shipped inside
  `addons/selectionTools/` carries the full GPL-3.0 text. The stricter of the
  two is honored here: **GPL-3.0**.
- **Changes:** paths rewritten into the merged tree.

## Combined work

Because the selection module is distributed under GPL-3.0, the combined work as
a whole is licensed **GPL-3.0-or-later**. MIT and LGPL-3.0 code can be combined
into a GPL-3.0 work; the reverse is not true, which is why this addon is not
offered under MIT despite two of three modules being MIT.
