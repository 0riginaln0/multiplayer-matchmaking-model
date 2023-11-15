class_name Request
extends RefCounted

signal request_handled

static var max_request_id: int = 0

var request_id: int
var player_id: int
var creation_time: String
var match_start_time: String
var match_end_time: String
var waiting_time: String

func _init(id: int, time: String) -> void:
	player_id = id
	creation_time = time
	request_id = max_request_id
	max_request_id += 1

func _to_string() -> String:
	return str("Request: ", request_id,"\nBy player: ", player_id,
	"\n", creation_time, "\nCreated: ", match_end_time, "\nWaited:  ", waiting_time)

func set_handled() -> void:
	var cr_t := Time.get_unix_time_from_datetime_string(creation_time)
	var match_start_t := Time.get_unix_time_from_datetime_string(match_start_time)
	var unix_waiting_time := match_start_t - cr_t
	waiting_time = Time.get_datetime_string_from_unix_time(unix_waiting_time)
	emit_signal("request_handled")

func get_creation_time() -> String:
	return creation_time
