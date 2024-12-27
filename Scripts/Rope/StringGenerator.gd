extends Node

var cursor: PackedScene = preload("res://Models/Board/Cursor_TMP_Joint.tscn")

var startJoint: Joint3D = null
var endJoint: Joint3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if GlobalVariables.SubLocation.name != "Board":
		return
	if not event is InputEventMouseButton:
		return
	var intersect = GlobalMethods.get_mouse_intersect(event.position)
	var leftButtonPressed = event.button_index == MOUSE_BUTTON_LEFT && event.pressed
	if leftButtonPressed and intersect.collider == self:
		var node = cursor.instantiate()
		node.intersect = intersect
		node.is_dragging = true
		node.mousePosition = intersect.position
		node.global_position = intersect.position
		node.scale = Vector3(0.02, 0.02, 0.02)
		get_parent().get_parent().add_child(node)
		node.draggingCollider = GlobalMethods.get_mouse_intersect(event.position).collider
		node.draggingCollider.set_collision_layer(false)