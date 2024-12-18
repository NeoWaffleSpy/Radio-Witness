extends Node

@export var CameraPOV: Camera3D
@export var ButtonGenerator: Control

var LocationList: Array[Node3D] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not CameraPOV:
		print("No Camera found")
		return
	for child in get_children():
		if child is Node3D:
			child.init(CameraPOV)
			LocationList.append(child)
	print(LocationList)
	ButtonGenerator.addMainChild(LocationList)
	ButtonGenerator.addChild(LocationList[0].SubLocationList)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
