extends Node3D

@export var DefaultLocation: Node3D
@export var radio: Node3D
var SubLocationList: Array[Node3D] = []
var CameraPOV: Camera3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init(cam: Camera3D) -> void:
	CameraPOV = cam
	if not DefaultLocation:
		DefaultLocation = get_children()[0]
	for child in get_children():
		if child is Node3D:
			SubLocationList.append(child)
			if child.name == "Radio":
				self.radio = child

func toggleRadio():

	if self.radio != null && self.radio.is_visible():
		print("show")
		self.radio.hideUI()
	
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
