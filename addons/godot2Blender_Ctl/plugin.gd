@tool
extends EditorPlugin

## Master plugin for the merged "Blender Feel" addon.
##
## Three upstream addons were folded into one plugin so there is a single
## enable/disable switch, one update path, and one place to fix when Godot
## changes an editor API:
##
##   modules/transform  -- G/R/S modal transform, axis constraints, Z pie menu
##   modules/viewport   -- `[` / `]` radial camera + viewport menus
##   modules/selection  -- Blender-like select/deselect/children commands
##
## Only the REGISTERED plugin receives `_handles`, `_edit`,
## `_forward_3d_gui_input` and `_forward_3d_draw_over_viewport`. Modules are
## plain EditorPlugin children, so this root forwards those four callbacks to
## whichever module declares them. `_ready`, `_input` and `_enter_tree` fire
## normally on children and need no forwarding.
##
## `add_context_menu_plugin` in modules/selection goes through the EditorNode
## singleton, so it works from an unregistered instance too.

const TransformModule := preload("modules/transform/plugin.gd")
const ViewportModule := preload("modules/viewport/plugin.gd")
const SelectionModule := preload("modules/selection/SelectionToolsPlugin.gd")

var _transform: EditorPlugin
var _viewport: EditorPlugin
var _selection: EditorPlugin


func _enter_tree() -> void:
	## The G/R/S modal transform needs every 3D viewport key event, not just the
	## ones the editor would otherwise forward. Without this, `_forward_3d_gui_input`
	## is never called for plain key presses and G/R/S silently do nothing.
	set_input_event_forwarding_always_enabled()

	## Transform first: it installs the overlay the viewport module draws into.
	_transform = _spawn(TransformModule, "TransformModule")
	_viewport = _spawn(ViewportModule, "ViewportModule")
	_selection = _spawn(SelectionModule, "SelectionModule")


func _exit_tree() -> void:
	for module in [_selection, _viewport, _transform]:
		if is_instance_valid(module):
			module.queue_free()
	_selection = null
	_viewport = null
	_transform = null


func _spawn(script: Script, node_name: String) -> EditorPlugin:
	var module: EditorPlugin = script.new()
	module.name = node_name
	add_child(module)
	return module


## --- callbacks that only the registered plugin receives ---------------------

func _handles(object: Object) -> bool:
	if is_instance_valid(_transform) and _transform.has_method("_handles"):
		return _transform._handles(object)
	return false


func _edit(object: Object) -> void:
	if is_instance_valid(_transform) and _transform.has_method("_edit"):
		_transform._edit(object)


func _forward_3d_gui_input(camera: Camera3D, event: InputEvent) -> int:
	if is_instance_valid(_transform) and _transform.has_method("_forward_3d_gui_input"):
		return _transform._forward_3d_gui_input(camera, event)
	return EditorPlugin.AFTER_GUI_INPUT_PASS


func _forward_3d_draw_over_viewport(overlay: Control) -> void:
	if is_instance_valid(_transform) and _transform.has_method("_forward_3d_draw_over_viewport"):
		_transform._forward_3d_draw_over_viewport(overlay)


func _make_visible(visible: bool) -> void:
	if is_instance_valid(_transform) and _transform.has_method("_make_visible"):
		_transform._make_visible(visible)
