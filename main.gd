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
	
	
	var request0 = player0.get_current_request()
	var request1 = player1.get_current_request()
	OS.delay_msec(2000)
	request0.set_handled()
	request1.set_handled()
	pass
