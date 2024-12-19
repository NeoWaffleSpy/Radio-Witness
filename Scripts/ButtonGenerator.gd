extends Control

@export var LocationPanel: VBoxContainer
@export var SubLocationPanel: VBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func clearLocation(): clear(LocationPanel)
func clearSubLocation(): clear(SubLocationPanel)
func clear(panel: VBoxContainer) -> void:
	for child in panel.get_children():
		if child is Button:
			clear_all_hooks(child)
		remove_child(child)
		child.queue_free()

func SwapPOV(node: Node3D):
	clearSubLocation()
	addChild(node.SubLocationList)
	node.MoveToDefault()

func clear_all_hooks(button: Button) -> void:
	var signal_list = button.get_signal_connection_list("pressed")
	for connection in signal_list:
		button.disconnect(connection.signal.get_name(), connection.callable)

func addMainChild(nodeList: Array[Node3D]) -> void:
	if not nodeList:
		print("Invalid node passed to addMainChild.")
		return
	var buttonList: Array[Button] = []
	for node in nodeList:
		var button = Button.new()
		buttonList.append(button)
		button.text = node.name
		EventManager.Location.create_event(node.name, self).bind(self, SwapPOV)
		button.pressed.connect(EventManager.Location.get_event(node.name).invoke.bind(node))
		LocationPanel.add_child(button)

func addChild(nodeList: Array[Node3D]) -> void:
	if not nodeList:
		print("Invalid node passed to addChild.")
		return
	var buttonList: Array[Button] = []
	for node in nodeList:
		var button = Button.new()
		buttonList.append(button)
		button.text = node.name
		EventManager.Location.create_event(node.name, self).bind(self, Callable(node.get_parent_node_3d(), "MoveTo"))
		button.pressed.connect(EventManager.Location.get_event(node.name).invoke.bind(node))
		SubLocationPanel.add_child(button)

func test_event(node: Node3D):
	print("Moved to node " + node.name)

func _notification(type):
	if type == NOTIFICATION_PREDELETE:
		EventManager.Location.unbind_all(self)
