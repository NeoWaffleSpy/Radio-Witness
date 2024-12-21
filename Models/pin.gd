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
	var intersect = get_nouse_intersect(event.position)

	if event is InputEventMouse:
		if intersect:
			mousePosition = intersect.position

	if event is InputEventMouseButton:
		var leftButtonPressed = event.button_index == MOUSE_BUTTON_LEFT && event.pressed
		var leftButtonReleased = event.button_index == MOUSE_BUTTON_LEFT && !event.pressed

		if leftButtonReleased:
			is_dragging = false
			drag_and_drop(intersect)
		elif leftButtonPressed:
			is_dragging = true
			drag_and_drop(intersect)

func drag_and_drop(intersect):
	if !draggingCollider && is_dragging:
		draggingCollider = intersect.collider
		draggingCollider.set_collision_layer(false)
	elif draggingCollider:
		draggingCollider.set_collision_layer(true)
		draggingCollider = null

func get_nouse_intersect(mousePos):
	var viewCam = get_viewport().get_camera_3d()
	var params = PhysicsRayQueryParameters3D.new()
	params.from = viewCam.project_ray_origin(mousePos)
	params.to = viewCam.project_position(mousePos, 1000)

	var worldSpace = get_world_3d().direct_space_state
	var result = worldSpace.intersect_ray(params)

	return result
