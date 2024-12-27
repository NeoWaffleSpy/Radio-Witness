extends Node3D

var draggingCollider
var mousePosition
var is_dragging = false

func _process(_delta: float):
	if draggingCollider:
		draggingCollider.global_position = mousePosition

func _input(event):
	if GlobalVariables.SubLocation.name != "Board":
		return
	if event is InputEventKey:
		return

	var intersect = GlobalMethods.get_mouse_intersect(event.position)

	if event is InputEventMouseButton:
		if intersect:
			mousePosition = intersect.position
		var leftButtonPressed = event.button_index == MOUSE_BUTTON_LEFT && event.pressed
		var leftButtonReleased = event.button_index == MOUSE_BUTTON_LEFT && !event.pressed

		if leftButtonReleased:
			is_dragging = false
			drag_and_drop(intersect)
		elif leftButtonPressed and intersect.collider == self:
			is_dragging = true
			drag_and_drop(intersect)
			get_viewport().set_input_as_handled()

func drag_and_drop(intersect):
	if !draggingCollider && is_dragging:
		draggingCollider = intersect.collider
		draggingCollider.set_collision_layer(false)
	elif draggingCollider:
		draggingCollider.set_collision_layer(true)
		draggingCollider = null
