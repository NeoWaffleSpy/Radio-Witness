extends Panel

func _init():
	self.visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_F1:
			self.visible = !self.visible
