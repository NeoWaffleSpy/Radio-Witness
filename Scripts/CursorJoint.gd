extends Draggable

func OnDrag():
	if draggingCollider:
		draggingCollider.global_position = mousePosition
		if intersect:
			draggingCollider.global_rotation = intersect.collider.rotation

func OnDragEnd():
	is_dragging = false
	if intersect.collider.has_method("GrabJointEnd"):
		intersect.collider.GrabJointEnd()
	draggingCollider = null
	intersect = null
	self.queue_free()
