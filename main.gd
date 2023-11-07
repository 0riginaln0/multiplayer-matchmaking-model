extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player1 = Player.new()
	print(player1)
	var player2 = Player.new()
	print(player2)
	print(player1.get_current_request())
	player2.create_new_request()
	
	print(player2.get_current_request())
	player1.create_new_request()
	print(player1.get_current_request())
	player1.create_new_request()
	print(player1.get_current_request())
	player1.create_new_request()
	print(player1.get_current_request())
	player2.create_new_request()
	print(player2.get_current_request())
	pass
