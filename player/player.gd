class_name Player
extends RefCounted

static var max_player_id: int = 0

var player_id: int
var request: Request = null
var requests: Array[Request]


func _init() -> void:
	player_id = max_player_id
	max_player_id += 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _to_string() -> String:
	return str("Player:", player_id)

func create_new_request() -> void:
	requests.append(request)
	request = Request.new(player_id)
	request.connect("request_handled", _on_request_handled)
	pass

func get_current_request() -> Request:
	return request

func _on_request_handled() -> void:
	print(str("I am player:", player_id,". And my request has been handled\n", request, "\n"))
	request.disconnect("request_handled", _on_request_handled)
	pass
