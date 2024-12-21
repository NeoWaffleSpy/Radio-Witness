extends Node

var Location: Node3D:
	set(node):
		if Location != node:
			Location = node
		SubLocation = node.DefaultLocation

var SubLocation: Node3D:
	set(node):
		if SubLocation == node:
			return
		SubLocation = node
		EventManager.Location.get_event(node.name).invoke(node)
