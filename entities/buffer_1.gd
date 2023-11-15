class_name Buffer1
extends Resource

static var buffer: Array[Request]

func are_enough_requests() -> bool:
	if buffer.size() >= GlobalVariables.PLAYERS_IN_MATCH:
		return true
	return false

func append(req: Request):
	buffer.append(req)

func pop_front() -> Request:
	return buffer.pop_front()

func _to_string() -> String:
	var output_string := "Bufer1:"
	for r in buffer:
		output_string = str(output_string, "\n", r.to_string())
	output_string = str(output_string, "\n")
	return output_string
