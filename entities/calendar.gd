class_name Calendar
extends Resource

static var calendar: Array[SpecialEvent]

func append(ev: SpecialEvent):
	calendar.append(ev)
	calendar.sort_custom(comparator)

func comparator(a: SpecialEvent, b: SpecialEvent) -> bool:
	if a.creation_time < b.creation_time:
		return true
	return false

func next_event() -> SpecialEvent:
	for event in calendar:
		if event.status == SpecialEvent.EVENT_STATUS.UNHANDLED:
			return event
		else:
			continue
	return null

func _to_string() -> String:
	var output_string: String = ""
	for ev in calendar:
		output_string += str("\n", ev.to_string(), "\n")
	return output_string
