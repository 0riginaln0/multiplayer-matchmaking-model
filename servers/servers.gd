class_name Servers
extends Node

enum ServerState {BUSY, FREE}

var servers: Array[Server]
# Called when the node enters the scene tree for the first time.

func _init() -> void:
	for i in range(GlobalVariables.SERVERS_COUNT):
		var new_server = Server.new()
		servers.append(new_server)

func find_free_server() -> int:
	for server in servers:
		if server.status == ServerState.FREE:
			return server.server_id
	return -1
	
func put_in_server(_players: AggregatedRequest):
	var serv_id = find_free_server()
	servers[serv_id].players = _players
	servers[serv_id].status = ServerState.BUSY
	servers[serv_id].run()


class Server:
	extends Resource
	
	static var max_server_id: int = 0
	var server_id: int
	
	var status: ServerState
	var players: AggregatedRequest
	
	func _init() -> void:
		status = ServerState.FREE
		server_id = max_server_id
		max_server_id += 1
		
	func run():
		for request in players.requests:
			request.set_handled()
		#создаём запись в календаре что сервер освободился
		print(str("Server ", server_id, " is free"))
