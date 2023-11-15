class_name SpecialEvent
extends RefCounted

enum EVENT_TYPE {
	NEW_REQUEST,
	IDLE_SERVER,
}

enum EVENT_STATUS {
	HANDLED,
	UNHANDLED,
}

var creation_time: String
var type: EVENT_TYPE
var status: EVENT_STATUS

var object

func _init(time: String, t: EVENT_TYPE, obj) -> void:
	creation_time = time
	type = t
	status = EVENT_STATUS.UNHANDLED
	object = obj