extends Node

@export var CameraPOV: Camera3D
@export var ButtonGenerator: Control

var LocationList: Array[Node3D] = []

func _ready() -> void:
	if not CameraPOV:
		GlobalMethods.fatal_error("No Camera found: " + CameraPOV.name)
	for child in get_children():
		if child is Node3D:
			child.init(CameraPOV)
			LocationList.append(child)
	GlobalVariables.Location = LocationList[0]
	ButtonGenerator.addMainChild(LocationList)
	ButtonGenerator.addChild(LocationList[0].SubLocationList)
