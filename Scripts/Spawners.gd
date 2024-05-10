extends Node

var rng = RandomNumberGenerator.new()
var timer = 0
var timermax = 7
var timermin = 2.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer <= 0:
		var spawnerlist = self.get_children()
		var spawnerindex = rng.randi_range(0, spawnerlist.size() -1)
		
		spawnerlist[spawnerindex].spawn()
		
		timer = rng.randf_range(timermin, timermax)
	timer -= delta
