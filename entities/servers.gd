class_name Servers
extends Node

enum ServerState {BUSY, FREE}

var servers: Array[Server]



func _init() -> void:
	for i in range(GlobalVariables.SERVERS_COUNT):
		var new_server = Server.new()
		servers.append(new_server)

func find_free_server(current_time: String) -> int:
	for server in servers:
		if server.busy_until < current_time:
			return server.server_id
	return -1

func put_in_server(_players: AggregatedRequest, current_time: String):
	var serv_id = find_free_server(current_time)
	servers[serv_id].players = _players
	servers[serv_id].run()


class Server:
	extends Resource
	
	static var max_server_id: int = 0
	var server_id: int
	
	var busy_until: String = "00:00:00"
	var players: AggregatedRequest
	
	var calendar: Calendar
	
	func _init() -> void:
		server_id = max_server_id
		max_server_id += 1
		calendar = Calendar.new()

	func run():
		var match_end_time: String
		for request in players.requests:
			var match_time := Time.get_unix_time_from_datetime_string(GlobalVariables.MATCH_TIME)
			var match_start_time := Time.get_unix_time_from_datetime_string(request.match_start_time)
			match_end_time = Time.get_datetime_string_from_unix_time(match_start_time + match_time)
			request.match_end_time = match_end_time
		busy_until = match_end_time
		
		var idle_server_event: SpecialEvent = SpecialEvent.new(
		match_end_time, SpecialEvent.EVENT_TYPE.IDLE_SERVER, self)
		calendar.append(idle_server_event)
		for request in players.requests:
			request.set_handled()
		print(str("Server ", server_id, " is free"))
	
	func _to_string() -> String:
		return str("ServerId: ", server_id, "\n", "Busy until: ", busy_until)
