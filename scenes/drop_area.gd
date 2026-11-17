extends Node2D

var hovered = false
var highlighted = false: set = _set_highlighted

func _ready():
	_set_highlighted(false)
	
func _mouse_entered(_area):
	hovered = true
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Highlight/Sprite2D.material, "shader_parameter/hovered", 1.0, 0.1)

func _mouse_exited(_area):
	hovered = false
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Highlight/Sprite2D.material, "shader_parameter/hovered", 0.0, 0.1)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed and hovered:
			if highlighted and game.dragged_object:
				game.dragged_object.dropped_on(get_parent_with_type())

func _set_highlighted(new_highlighted):
	highlighted = new_highlighted
	$Highlight.visible = highlighted
	
func get_parent_with_type():
	var parent = get_parent()
	while(!parent.get("type")):
		parent = parent.get_parent()
	return parent

func highlight(type):
	if get_parent_with_type().type == type:
		_set_highlighted(true)
