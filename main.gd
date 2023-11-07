extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player0 = Player.new()
	print(player0)
	var player1 = Player.new()
	print(player1)
	
	player0.create_new_request()
	print(player0.get_current_request())
	
	player1.create_new_request()
	print(player1.get_current_request())
	
	var player2 = Player.new()
	player2.create_new_request()
	var player3 = Player.new()
	player3.create_new_request()
	var player4 = Player.new()
	player4.create_new_request()
	var player5 = Player.new()
	player5.create_new_request()
	#print(player5)
	var player6 = Player.new()
	player6.create_new_request()
	#print(player6)
	var player7 = Player.new()
	player7.create_new_request()
	
	var request0 = player0.get_current_request()
	var request1 = player1.get_current_request()
	request0.set_handled()
	request1.set_handled()
	var request3 = player7.get_current_request()
	request3.set_handled()
	pass
