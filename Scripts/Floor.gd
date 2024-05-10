extends Node

var rng = RandomNumberGenerator.new()

func _process(delta):
	if Input.is_action_just_pressed("debug_restore_floor"):
		restore_floor()
	elif Input.is_action_just_pressed("debug_restore_one"):
		restore()

func restore_floor():
	for i in get_children():
		i.on()

func restore():
	var broke_list = []
	for i in get_children():
		if i.broken == true:
			broke_list.append(i)
	
	if broke_list.size() > 0:
		var restoreindex = rng.randi_range(0, broke_list.size() -1)
		broke_list[restoreindex].on()
