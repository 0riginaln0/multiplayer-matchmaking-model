class_name Behavior
extends RefCounted

const DAY_SUNDAY := 0
const DAY_MONDAY := 1
const DAY_TUESDAY := 2
const DAY_WEDNESDAY := 3
const DAY_THURSDAY := 4
const DAY_FRIDAY := 5
const DAY_SATURDAY := 6
const DAYS_OF_THE_WEEK = [DAY_SUNDAY, DAY_MONDAY, DAY_TUESDAY, DAY_WEDNESDAY, DAY_THURSDAY, DAY_FRIDAY, DAY_SATURDAY]

var preferable_matches_per_day := 4
# var matches_played_today передаётся из игрока

var preferable_time := 72000 # 20:00 = 3600 секунд (час) * 20 = 72000
var dev_time := 7200 # Разброс вечера 2 часа


var preferable_days: Array[int] = [DAY_SUNDAY, DAY_SUNDAY,
						DAY_MONDAY,
						DAY_TUESDAY,
						DAY_WEDNESDAY,
						DAY_THURSDAY,
						DAY_FRIDAY, DAY_FRIDAY, DAY_FRIDAY,
						DAY_SATURDAY, DAY_SATURDAY, DAY_SATURDAY]


var next_request_date: String
var next_request_time: String

var cur_weekday: int

func calculate_next_request_datetime(match_end_time: String,
								matches_played_today: int) -> String:
	
	var current_weekday := get_weekday(match_end_time)
	cur_weekday = current_weekday
	var current_time := match_end_time.get_slice("T", 1)
	var current_date := match_end_time.get_slice("T", 0)
	
	# Выбор дня для след. игры
	# Выбираем день, отталкиваясь от количества игр сыгранных за сегодня
	## Если сыграл меньше половины желаемого, то шанс сыграть сегодня выше
	if matches_played_today < (preferable_matches_per_day as float / 2):
		var chance = randf()
		if chance < 0.7:
			# Играешь сегодня
			next_request_date = current_date
			## Выбрать время от текущего до 23:59:59
			next_request_time = get_time_bounded(current_time, "23:59:59")
			pass
		else:
			# Играешь в другой день
			# Выбор дня
			next_request_date = get_next_date(current_weekday, current_date)
			# Выбор времени
			next_request_time = get_time()
			pass
	## Иначе, если сыграл больше половины желаемого, то шанс сыграть сегодня меньше
	else:
		var chance = randf()
		if chance < 0.3:
			# Играешь сегодня
			next_request_date = current_date
			## Выбрать время от текущего до 23:59:59
			next_request_time = get_time_bounded(current_time, "23:59:59")
			pass
		else:
			# Играешь в другой день
			# Выбор дня
			next_request_date = get_next_date(current_weekday, current_date)
			# Выбор времени
			next_request_time = get_time()
			pass
	return next_request_date + "T" + next_request_time

func get_weekday(datetime: String) -> int:
	var dt_dict: Dictionary = Time.get_datetime_dict_from_datetime_string(datetime, true)
	var weekday: int = dt_dict.get("weekday")
	return weekday

func get_time() -> String:
	return Time.get_time_string_from_unix_time(randfn(preferable_time, dev_time))

func get_time_bounded(lower_bound: String, upper_bound: String) -> String:
	var unix_time = Time.get_unix_time_from_datetime_string(lower_bound) + 1
	unix_time = randf_range(Time.get_unix_time_from_datetime_string(lower_bound), 
					Time.get_unix_time_from_datetime_string(upper_bound))
	return Time.get_time_string_from_unix_time(unix_time)

func get_next_date(current_weekday: int, current_date: String) -> String:
	var days := preferable_days.duplicate(true)
	# Удаляем все текущие дни недели из days
	var new_days := days.filter(remove_current_day)
	# Выбираем рандомный день из оставшихся
	var new_day: int = new_days[randi() % new_days.size()]
	# Считать разницу текущего и выбранного дня
	var dif = calculate_day_difference(current_weekday, new_day)
	dif *= 86400
	# переводим эту разницу в unix прибавляем её к текущей дате, которую тоже перевели в unix
	# 86400
	var unix_date = Time.get_unix_time_from_datetime_string(current_date)
	unix_date += dif
	return Time.get_date_string_from_unix_time(unix_date)

func remove_current_day(day):
	return day != cur_weekday

func calculate_day_difference(day1: int, day2: int) -> int:
	var day1_index = DAYS_OF_THE_WEEK.find(day1)
	var day2_index = DAYS_OF_THE_WEEK.find(day2)
	var difference = day2_index - day1_index
	if difference < 0:
		difference += 7
	return difference
