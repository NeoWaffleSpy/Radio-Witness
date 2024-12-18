extends Node

class Category:
	var events = {}

	func __call__(event_name: String):
		if not events.has(event_name):
			printerr("Calling a non existant event: " + event_name)
			return null
		return events[event_name]

	func create_event(event_name: String):
		if events.has(event_name):
			printerr("Creating an already existing event: " + event_name)
		else:
			events[event_name] = _Event.new(event_name)

	class _Event:
		var event_name = ""
		var observers = {}

		func _init(event_name: String):
			self.event_name = event_name

		func bind(listener: Object, method: String):
			observers.append({"listener": listener, "method": method})

		func invoke(data = null):
			for handler in observers:
				handler.method.call(data)
