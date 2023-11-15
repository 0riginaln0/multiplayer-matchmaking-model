class_name Simulator
extends Node

var calendar: Calendar
var b1: Buffer1
var b2: Buffer2
var servers: Servers
var players: Array[Player]

var current_event: SpecialEvent

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	calendar = Calendar.new()
	b1 = Buffer1.new()
	b2 = Buffer2.new()
	servers = Servers.new()
	players = []
	# Запустить всех игроков
	for i in range(GlobalVariables.PLAYERS_COUNT):
		var new_player := Player.new()
		new_player.create_new_request()
		players.append(new_player)

func start():
	print("Simulation started")
	#print("-----------------")
	#print(calendar.to_string())
	current_event = calendar.next_event()
	while(not is_end_of_simulation()):
		#print(calendar.to_string())
		#print(b1.to_string())
		#print(b2.to_string())
		#print(servers.to_string())
		#print("-----------------")
		#print(calendar.to_string())
		match current_event.type:
			SpecialEvent.EVENT_TYPE.NEW_REQUEST:
				handle_new_request()
				current_event.status = SpecialEvent.EVENT_STATUS.HANDLED
				#print("-----------------")
				#print(calendar.to_string())
			SpecialEvent.EVENT_TYPE.IDLE_SERVER:
				handle_idle_server()
				current_event.status = SpecialEvent.EVENT_STATUS.HANDLED
				#print("-----------------")
				#print(calendar.to_string())
			_:
				print("calendar is empty")
		current_event = calendar.next_event()
	print_results()
	print_results2()
	print("Simulation finished")

func handle_new_request():
	b1.append(current_event.object)
	if not b1.are_enough_requests():
		return
	var requests: Array[Request] = []
	for i in range(GlobalVariables.PLAYERS_IN_MATCH):
		requests.append(b1.pop_front())
	match servers.find_free_server(current_event.creation_time):
		-1:
			var aggregated_request = AggregatedRequest.new(requests)
			b2.append(aggregated_request)
			return
		_:
			for r in requests:
				r.match_start_time = current_event.creation_time
			var aggregated_request = AggregatedRequest.new(requests)
			servers.put_in_server(aggregated_request, current_event.creation_time)

func handle_idle_server():
	if b2.is_empty():
		# фиксировать простой прибора
		return
	var aggregated_request = b2.pop_front()
	servers.put_in_server(aggregated_request, current_event.creation_time)

func is_end_of_simulation() -> bool:
	if GlobalVariables.SIMULATION_END_TIME < current_event.creation_time:
		return true
	return false

func print_results() -> void:
	var count_avg_wait_time = 0
	for p in players:
		count_avg_wait_time += p.get_avg_wait_time()
	print(Time.get_time_string_from_unix_time(count_avg_wait_time / players.size()))

func print_results2() -> void:
	var sum_wait_time = 0
	for p in players:
		for r in p.requests:
			sum_wait_time += Time.get_unix_time_from_datetime_string(r.waiting_time)
	print(Time.get_time_string_from_unix_time(sum_wait_time / players.size()))
