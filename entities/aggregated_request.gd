class_name AggregatedRequest
extends RefCounted

var requests: Array[Request]

func _init(_requests: Array[Request]) -> void:
	requests = _requests
