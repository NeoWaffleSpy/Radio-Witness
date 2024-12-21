extends Node

class_name EventCategory

var eventList = {}

func get_event(event_name: String) -> _Event:
	if not eventList.has(event_name):
		printerr("Calling a non existant event: " + event_name)
		return null
	return eventList[event_name].event

func create_event(listener: String, event_name: String) -> _Event:
	if eventList.has(event_name):
		GlobalMethods.fatal_error("Event Already exist in this category")
	eventList[event_name] = {"event": _Event.new(event_name), "listener": listener}
	return eventList[event_name].event

func delete_event(event_name: String, listener: String):
	if eventList.has(event_name) && eventList[event_name].listener == listener:
		eventList[event_name].event.delete_event()
		eventList[event_name] = null

func delete_all_event(listener: String):
	for e in eventList:
		if eventList[e].listener == listener:
			eventList[e].event.delete_event()
			e = null

func unbind_all(listener: String):
	for e in eventList:
		if eventList[e].listener == listener:
			eventList[e].event.unbind_all(listener)

func _notification(type):
	if type == NOTIFICATION_PREDELETE:
		for e in eventList:
			eventList[e].event.delete_event()
			eventList = null

class _Event:
	var event_name = ""
	var observers = []

	func _init(name: String):
		self.event_name = name

	func bind(listener: String, method: Callable):
		observers.append({"listener": listener, "method": method})

	func unbind(listener: String, method: Callable):
		for i in range(observers.size()):
			if observers[i].listener == listener and observers[i].method == method:
				observers.remove_at(i)
				return

	func unbind_all(listener: String):
		for i in range(observers.size()):
			if observers[i].listener == listener:
				observers.remove_at(i)
				return

	func invoke(data = null):
		for handler in observers:
			handler.method.call(data)

	func delete_event():
		observers.clear()
		print("Event has been cleared: " + event_name)
