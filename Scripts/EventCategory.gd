extends Node

class_name EventCategory

var events = {}
#var local_event = _Event.new(self.name)

func _ready():
	printerr("class initialized")

func get_event(event_name: String) -> _Event:
	if not events.has(event_name):
		printerr("Calling a non existant event: " + event_name)
		return null
	return events[event_name].event

func create_event(event_name: String, listener: Object) -> _Event:
	if events.has(event_name):
		printerr("Creating an already existing event: " + event_name)
	else:
		events[event_name] = {"event": _Event.new(event_name), "listener": listener}
	return events[event_name].event

func delete_event(event_name: String, listener: Object):
	if events.has(event_name) && events[event_name].listener == listener:
		#events[event_name] = {"event": null, "listener": null}
		events[event_name] = null

func delete_all_event(listener: Object):
	for event in events:
		if event.listener == listener:
			event.unbind_all(listener)
			#event = {"event": null, "listener": null}
			events = null

func unbind_all(listener: Object):
	for event in events:
		if event.listener == listener:
			event.unbind_all(listener)

#	func invoke(data = null):
#		local_event.invoke(data)

class _Event:
	var event_name = ""
	var observers = []

	func _init(name: String):
		self.event_name = name

	func bind(listener: Object, method: Callable):
		observers.append({"listener": listener, "method": method})

	func unbind(listener: Object, method: Callable):
		for i in range(observers.size()):
			if observers[i].listener == listener and observers[i].method == method:
				observers.remove_at(i)
				return

	func unbind_all(listener: Object):
		for i in range(observers.size()):
			if observers[i].listener == listener:
				observers.remove_at(i)
				return

	func invoke(data = null):
		for handler in observers:
			handler.method.call(data)

	func _notification(type):
		if type == NOTIFICATION_PREDELETE:
			observers.clear()
			print("Event has been cleared: " + event_name)
