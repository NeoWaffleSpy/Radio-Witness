extends Node3D

@export var dialog_json: JSON
@onready var state = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	($EzDialogue as EzDialogue).start_dialogue(dialog_json, state, "intro")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func hideUI():
	$dialoguesBox.is_hidden = !$dialoguesBox.is_hidden
	$dialoguesBox.visible = $dialoguesBox.is_hidden
func _on_ez_dialogue_dialogue_generated(response: DialogueResponse):
	$dialoguesBox.clear()
	$dialoguesBox.add_text(response.text)
	
	for choice in response.choices:
		$dialoguesBox.add_choice(choice)
	
