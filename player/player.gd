class_name Player
extends RefCounted

static var max_player_id: int = 0

var player_id: int
var request: Request = null
var requests: Array[Request]

var calendar: Calendar

func _init() -> void:
	player_id = max_player_id
	max_player_id += 1
	calendar = Calendar.new()


func _to_string() -> String:
	return str("Player:", player_id)

func create_new_request() -> void:
	if request != null:
		requests.append(request)
	var next_request_time = calculate_next_request_time()
	request = Request.new(player_id, next_request_time)
	request.connect("request_handled", _on_request_handled)
	var new_request: SpecialEvent = SpecialEvent.new(
		next_request_time, SpecialEvent.EVENT_TYPE.NEW_REQUEST, 
		SpecialEvent.EVENT_STATUS.UNHANDLED, request)
	calendar.append(new_request)
	

func calculate_next_request_time() -> String:
	if request == null:
		var seed_time = Time.get_unix_time_from_datetime_string(GlobalVariables.SIMULATION_START_TIME)
		var delta_t = Time.get_unix_time_from_datetime_string("0:2:00")
		var next_request_time = Time.get_datetime_string_from_unix_time(seed_time + delta_t)
		return next_request_time
	var seed_t = Time.get_unix_time_from_datetime_string(request.end_time)
	var delta_t = Time.get_unix_time_from_datetime_string("0:2:00")
	var next_request_time = Time.get_datetime_string_from_unix_time(seed_t + delta_t)
	return next_request_time

func get_current_request() -> Request:
	return request

func _on_request_handled() -> void:
	print(str("I am player:", player_id,". And my request has been handled\n", request, "\n"))
	request.disconnect("request_handled", _on_request_handled)
	create_new_request()
