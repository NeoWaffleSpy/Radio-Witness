class_name ChoiceButton extends Button

var choice_index = 0
signal choice_selected(choice_index)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	choice_selected.emit(choice_index)
	pass # Replace with function body.