extends Node

@export var CameraPOV: Camera3D
@export var ButtonGenerator: Control

var LocationList: Array[Node3D] = []

func _ready() -> void:
	if not CameraPOV:
		print("No Camera found: " + CameraPOV.name)
		return
	for child in get_children():
		if child is Node3D:
			child.init(CameraPOV)
			LocationList.append(child)
	print(LocationList)
	ButtonGenerator.addMainChild(LocationList)
	ButtonGenerator.addChild(LocationList[0].SubLocationList)

func _notification(type):
	if type == NOTIFICATION_PREDELETE:
		EventManager.Position.delete_all_event(self)
