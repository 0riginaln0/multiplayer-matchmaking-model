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

func _to_string() -> String:
	var _type
	match type:
		EVENT_TYPE.IDLE_SERVER:
			_type = "IDLE SERVER"
		EVENT_TYPE.NEW_REQUEST:
			_type = "NEW REQUEST"
	var _status
	match status:
		EVENT_STATUS.HANDLED:
			_status = "HANDLED"
		EVENT_STATUS.UNHANDLED:
			_status = "UNHANDLED"
	var output_string: String = str(_type, "\n", creation_time, "\n", _status)
	return output_string
