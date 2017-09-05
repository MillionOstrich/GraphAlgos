extends Area2D

export var color_default = Color(0.5, 0.5, 1)
export var color_highlighted = Color(1,1,1)
export var color_selected = Color(1, 0.5, 0.5)

var is_selected = false
var is_highlighted = false

func set_selected(_selected):
	is_selected = _selected
	
func get_selected():
	return is_selected
	
func get_highlighted():
	return is_highlighted
	
func _ready():
	set_selected(false)
	connect("mouse_enter", self, "_on_mouse_enter")
	connect("mouse_exit", self, "_on_mouse_exit")

func _on_mouse_enter():
	is_highlighted = true
	_update_poly()
	
func _on_mouse_exit():
	is_highlighted = false
	_update_poly()

func _update_poly():
	if is_selected:
		get_node("Poly").set_color(color_selected)
	else:
		if is_highlighted:
			get_node("Poly").set_color(color_highlighted)
		else:
			get_node("Poly").set_color(color_default)