class_name Simulator
extends Node

var calendar: Calendar = Calendar.new()
var b1: Buffer1 = Buffer1.new()
var b2: Buffer2 = Buffer2.new()
var servers: Servers = Servers.new()

var current_event: SpecialEvent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func start():
	print("Simulation started")
	while(not is_end_of_simulation()):
		current_event = calendar.get_next_special_event()
		match current_event.EVENT_TYPE:
			SpecialEvent.EVENT_TYPE.NEW_REQUEST:
				handle_new_request()
			SpecialEvent.EVENT_TYPE.IDLE_SERVER:
				handle_idle_server()
	print("Simulation finished")

func handle_new_request():
	b1.append(current_event.object)
	if not b1.are_enough_requests():
		return
	var requests: Array[Request] = []
	for i in range(GlobalVariables.PLAYERS_IN_MATCH):
		requests.append(b1.pop_front())
	match servers.find_free_server():
		-1:
			var aggregated_request = AggregatedRequest.new(requests)
			b2.append(aggregated_request)
			return
		_:
			for r in requests:
				r.match_start_time = current_event.creation_time
			var aggregated_request = AggregatedRequest.new(requests)
			servers.put_in_server(aggregated_request)

func handle_idle_server():
	if b2.is_empty():
		# фиксировать простой прибора
		return
	var aggregated_request = b2.pop_front()
	servers.put_in_server(aggregated_request)

func is_end_of_simulation() -> bool:
	if GlobalVariables.SIMULATION_END_TIME < current_event.creation_time:
		return true
	return false
