class_name Buffer2
extends Resource

static var buffer: Array[AggregatedRequest]

func is_empty() -> bool:
	return buffer.is_empty()
	
func append(ag_req: AggregatedRequest):
	buffer.append(ag_req)

func pop_front() -> AggregatedRequest:
	return buffer.pop_front()

func _to_string() -> String:
	var output_string := "Buffer2:"
	for ag_req in buffer:
		output_string = str(output_string, "\n", ag_req.to_string())
	output_string = str(output_string, "\n")
	return output_string
