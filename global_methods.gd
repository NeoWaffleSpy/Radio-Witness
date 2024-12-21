extends Node

func fatal_error(msg: String):
	if msg:
		printerr(msg)
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit(1)
