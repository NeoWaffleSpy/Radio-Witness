extends Node3D

class_name Draggable

var draggingCollider
var mousePosition
var intersect
var is_dragging = false

# Make the class abstract
func _init():
	if self.get_class() == "Draggable":
		push_error("Draggable is an abstract class and cannot be instantiated directly.")
		queue_free()

func _ready():
	pass

func _input(event):
	if GlobalVariables.SubLocation.name != "Board":
		return
	if not event is InputEventMouse:
		return

	intersect = GlobalMethods.get_mouse_intersect(event.position)

	# Update mouse position
	if intersect:
		mousePosition = intersect.position

	# Pick up and drop
	if event is InputEventMouseButton:
		var leftButtonPressed = event.button_index == MOUSE_BUTTON_LEFT && event.pressed
		var leftButtonReleased = event.button_index == MOUSE_BUTTON_LEFT && !event.pressed

		if leftButtonReleased:
			OnDragEnd()
		elif leftButtonPressed and intersect.collider == self:
			OnDragStart(event)
	OnDrag()

# func to be overridden
func OnDragStart(_event: InputEventMouse):
	pass

# func to be overridden
func OnDrag():
	pass

# func to be overridden
func OnDragEnd():
	pass

func _drag_and_drop():
	if !draggingCollider && is_dragging:
		draggingCollider = intersect.collider
		draggingCollider.set_collision_layer(false)
	elif draggingCollider:
		draggingCollider.set_collision_layer(true)
		draggingCollider = null
