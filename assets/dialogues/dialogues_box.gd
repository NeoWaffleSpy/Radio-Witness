extends Node2D


@onready var  choice_button_scene = preload("res://assets/dialogues/ChoiceButton.tscn")
var choice_buttons: Array[Button] = []
var is_hidden = true
func _ready():
	add_choice("choice one")
	add_choice("choice two")
	
func clear():
	$VBoxContainer/Label.text = ""
	for choice in choice_buttons:
		$VBoxContainer.remove_child(choice)
	choice_buttons = []
func add_text(text: String):
	$VBoxContainer/Label.text = text
	pass

func add_choice(choice_text: String):
	var button_obj: ChoiceButton = choice_button_scene.instantiate()
	button_obj.choice_index = choice_buttons.size()
	button_obj.text = choice_text
	choice_buttons.push_back(button_obj)
	
	button_obj.choice_selected.connect(_on_choice_selected)
	$VBoxContainer.add_child(button_obj)

func _on_choice_selected(choice_index: int):
	print(choice_index)
	($"../EzDialogue" as EzDialogue).next(choice_index)
	
