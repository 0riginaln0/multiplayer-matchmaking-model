extends Node

var thread: Thread
var sim: Simulator
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sim = Simulator.new()
	$ProgressBar.min_value = Time.get_unix_time_from_datetime_string(GlobalVariables.SIMULATION_START_TIME)
	$ProgressBar.max_value = Time.get_unix_time_from_datetime_string(GlobalVariables.SIMULATION_END_TIME)

func _on_button_button_up() -> void:
	$Timer.start()
	thread = Thread.new()
	thread.start(start_simulation)

func start_simulation() -> void:
	sim.start()
	print("Вот и всё")


func _on_timer_timeout() -> void:
	$ProgressBar.value = Time.get_unix_time_from_datetime_string(sim.current_event.creation_time)
