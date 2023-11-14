class_name Request
extends RefCounted

signal request_handled

static var max_request_id: int = 0

var request_id: int
var player_id: int
var creation_time: String
var end_time: String
var processing_time: String

func _init(id: int, time: String) -> void:
	player_id = id
	creation_time = time #Time.get_datetime_string_from_system()
	request_id = max_request_id
	max_request_id += 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _to_string() -> String:
	return str("Request: ", request_id," by player: ", player_id,
	"\n", creation_time, "\n", end_time, "\n", processing_time)

func set_handled() -> void:
	end_time = Time.get_datetime_string_from_system()
	var t_start = Time.get_unix_time_from_datetime_string(creation_time)
	var t_end = Time.get_unix_time_from_datetime_string(end_time)
	processing_time = str((t_end - t_start))
	emit_signal("request_handled")

func get_creation_time() -> String:
	return creation_time
