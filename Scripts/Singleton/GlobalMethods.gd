extends Node3D

# Create a fatal error that properly quit the scene
func fatal_error(msg: String = ""):
	if msg.length():
		printerr(msg)
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit(1)

# Get the 3D object under the mouse
func get_mouse_intersect(mousePos):
	var viewCam = get_viewport().get_camera_3d()
	var params = PhysicsRayQueryParameters3D.new()
	params.from = viewCam.project_ray_origin(mousePos)
	params.to = viewCam.project_position(mousePos, 1000)

	var worldSpace = get_world_3d().direct_space_state
	var result = worldSpace.intersect_ray(params)

	return result