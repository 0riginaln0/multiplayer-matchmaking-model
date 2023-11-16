class_name Player
extends RefCounted

static var max_player_id: int = 0

var player_id: int
var request: Request = null
var requests: Array[Request]

var matches_played_per_day := 0
var last_match_end_time := ""

var behavior: Behavior

var calendar: Calendar

func _init() -> void:
	player_id = max_player_id
	max_player_id += 1
	calendar = Calendar.new()
	behavior = Behavior.new()


func _to_string() -> String:
	return str("Player:", player_id)

func create_new_request() -> void:
	if request != null:
		requests.append(request)
	var next_request_time := calculate_next_request_time()
	request = Request.new(player_id, next_request_time)
	request.connect("request_handled", _on_request_handled)
	var new_request_event: SpecialEvent = SpecialEvent.new(
		next_request_time, SpecialEvent.EVENT_TYPE.NEW_REQUEST, request)
	calendar.append(new_request_event)

func get_current_request() -> Request:
	return request

func _on_request_handled() -> void:
	#print(str("I am player:", player_id,". And my request has been handled\n", request, "\n"))
	if requests.is_empty():
		matches_played_per_day += 1
	# взять дату, сравнить с другой датой, которую тоже надо взять
	# Если дата lastmatchendtime такая же, как и request.matchendtime то matches_played_per_day += 1
	else:
		var current_date = request.match_end_time.get_slice("T", 0)
		var last_date = last_match_end_time.get_slice("T", 0)
		if current_date == last_date:
			matches_played_per_day += 1
		else:
		# иначе, приравниваем к единице matches_played_per_day = 1
			matches_played_per_day = 1
	
	last_match_end_time = request.match_end_time
	request.disconnect("request_handled", _on_request_handled)
	create_new_request()

func get_avg_wait_time():
	var sum_wait_time := 0.0
	for r in requests:
		sum_wait_time += Time.get_unix_time_from_datetime_string(r.waiting_time)
	return sum_wait_time / requests.size()

func get_b2_avg_wait_time():
	var sum_b2_wait_time := 0.0
	for r in requests:
		var t_start = Time.get_unix_time_from_datetime_string(r.b2_waiting_start_time)
		var t_end = Time.get_unix_time_from_datetime_string(r.match_start_time)
		sum_b2_wait_time += (t_end - t_start)
	return sum_b2_wait_time


#func calculate_next_request_time() -> String:
#	if request == null:
#		var seed_time = Time.get_unix_time_from_datetime_string(GlobalVariables.SIMULATION_START_TIME)
#		var delta_t = Time.get_unix_time_from_datetime_string("0:2:00")
#		var next_request_time = Time.get_datetime_string_from_unix_time(seed_time + delta_t)
#		return next_request_time
#	var seed_t = Time.get_unix_time_from_datetime_string(request.match_end_time)
#	var delta_t = Time.get_unix_time_from_datetime_string("0:3:00")
#	var next_request_time = Time.get_datetime_string_from_unix_time(seed_t + delta_t)
#	return next_request_time
	
func calculate_next_request_time() -> String:
	if request == null:
		return behavior.calculate_next_request_datetime(GlobalVariables.SIMULATION_START_TIME,
									get_matches_played_per_day())
	return behavior.calculate_next_request_datetime(request.match_end_time,
									get_matches_played_per_day())

func get_matches_played_per_day() -> int:
	return matches_played_per_day
