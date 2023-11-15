class_name Calendar
extends Resource

static var calendar: Array[SpecialEvent]

func append(ev: SpecialEvent):
	# Добавить сортирвку
	calendar.append(ev)

func next_event():
	pass
