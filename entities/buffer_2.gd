class_name Buffer2
extends Resource

static var buffer: Array[AggregatedRequest]

func is_empty() -> bool:
	return buffer.is_empty()
	
func append(ag_req: AggregatedRequest):
	buffer.append(ag_req)

func pop_front() -> AggregatedRequest:
	return buffer.pop_front()
