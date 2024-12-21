extends Node3D

@export var DefaultLocation: Node3D

var SubLocationList: Array[Node3D] = []
var CameraPOV: Camera3D

func init(cam: Camera3D) -> void:
	CameraPOV = cam
	for child in get_children():
		if child is Node3D:
			EventManager.Location.create_event(self.name, child.name).bind(self.name, MoveTo)
			SubLocationList.append(child)
			if not DefaultLocation:
				DefaultLocation = child
	
func MoveToDefault() -> void: MoveTo(DefaultLocation)

func MoveTo(node: Node3D) -> void:
	if not CameraPOV:
		print("No Camera found")
		return
	CameraPOV.reparent(node)
	var tween = create_tween().set_parallel()

	tween.tween_property(
		CameraPOV,
		"transform:origin",
		Vector3(0, 0, 0),
		0.5
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		CameraPOV,
		"transform:basis",
		Basis(),
		0.5
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	#CameraPOV.global_transform.origin = Vector3(0, 0, 0)
	#CameraPOV.global_transform.basis = Basis()
	pass

func _notification(type):
	if type == NOTIFICATION_PREDELETE:
		EventManager.Location.delete_all_event(self.name)
