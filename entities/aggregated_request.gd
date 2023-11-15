class_name AggregatedRequest
extends RefCounted

var requests: Array[Request]

func _init(_requests: Array[Request]) -> void:
	requests = _requests

func _to_string() -> String:
	var output_string := ""
	for r in requests:
		output_string = str(output_string, "\n", r.to_string())
	return output_string
