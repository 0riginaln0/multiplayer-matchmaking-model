class_name Player
extends Node

static var max_player_id: int = 0

var player_id: int

func _init() -> void:
	player_id = max_player_id
	max_player_id += 1
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _to_string() -> String:
	return str("Player:", player_id)

func create_request():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
