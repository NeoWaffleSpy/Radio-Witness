extends Draggable

func OnDragStart(event: InputEventMouse):
	is_dragging = true
	_drag_and_drop()
	intersect = GlobalMethods.get_mouse_intersect(event.position)
	#get_viewport().set_input_as_handled()

func OnDrag():
	if draggingCollider:
		draggingCollider.global_position = mousePosition
		if intersect:
			draggingCollider.global_rotation = intersect.collider.rotation

func OnDragEnd():
	is_dragging = false
	_drag_and_drop()
	intersect = null