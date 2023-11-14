class_name Calendar
extends Resource

static var calendar: Array[SpecialEvent]

func append(ev: SpecialEvent):
	calendar.append(ev)

func next_event():
	# todo
	pass
	
func get_next_special_event() -> SpecialEvent:
	# TODO:
	return calendar[0]
	pass
