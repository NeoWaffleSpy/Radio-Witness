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

func clear_all_hooks(button: Button) -> void:
	var signal_list = button.get_signal_connection_list("pressed")
	for connection in signal_list:
		button.disconnect("pressed", Callable(connection.target, connection.method))

func addMainChild(nodeList: Array[Node3D]) -> void:
	if not nodeList:
		print("Invalid node passed to addMainChild.")
		return
	var buttonList: Array[Button] = []
	for node in nodeList:
		var button = Button.new()
		buttonList.append(button)
		button.text = node.name
		button.pressed.connect(Callable(node, "MoveToDefault"))
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
		button.pressed.connect(Callable(node.get_parent_node_3d(), "MoveTo").bind(node))
		SubLocationPanel.add_child(button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
