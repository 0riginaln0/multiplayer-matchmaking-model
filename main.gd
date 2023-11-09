extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var b1 = Buffer1.new()
	var b2 = Buffer2.new()
	var servers = Servers.new()
	
	var player0 = Player.new()
	player0.create_new_request()
	var player1 = Player.new()
	player1.create_new_request()
	var player2 = Player.new()
	player2.create_new_request()
	var player3 = Player.new()
	player3.create_new_request()
	var player4 = Player.new()
	player4.create_new_request()
	var player5 = Player.new()
	player5.create_new_request()
	var player6 = Player.new()
	player6.create_new_request()
	var player7 = Player.new()
	player7.create_new_request()
	
	b1.append(player0.get_current_request())
	b1.append(player1.get_current_request())
	b1.append(player2.get_current_request())
	print(b1.are_enough_requests())
	b1.append(player3.get_current_request())
	b1.append(player4.get_current_request())
	b1.append(player5.get_current_request())
	b1.append(player6.get_current_request())
	b1.append(player7.get_current_request())
	print(b1.are_enough_requests())
	var requests: Array[Request]
	for i in range(4):
		requests.append(b1.pop_front())
	var agr_req: AggregatedRequest = AggregatedRequest.new(requests)
	b2.append(agr_req)
	print(servers.find_free_server())
	servers.put_in_server(b2.pop_front())
	
	
	pass
