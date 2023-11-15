extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sim = Simulator.new()
	sim.start()
	print("Вот и всё")
	pass
