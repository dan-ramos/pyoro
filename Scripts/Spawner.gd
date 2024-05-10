extends Marker3D

var bean = preload("res://Scenes/bean.tscn")

func _process(delta):
	if Input.is_action_just_pressed("debug_spawn"):
		spawn()

func spawn():
	var instance = bean.instantiate()
	add_child(instance)
