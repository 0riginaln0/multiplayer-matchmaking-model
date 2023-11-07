class_name Request
extends Node

static var max_request_id: int = 0

var request_id: int
var player_id: int
var creation_time
var end_time
var processing_time

func _init(id: int) -> void:
	player_id = id
	creation_time = Time.get_datetime_string_from_system()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _to_string() -> String:
	return str("Request: ", request_id, " by player: ", player_id, "\n", creation_time)

func create_request():
	request_id = max_request_id
	max_request_id += 1
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
