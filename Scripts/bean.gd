extends Area3D

var speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= speed * delta
	
func delete():
	queue_free()



func _on_area_entered(area):
	if (area.is_in_group('block')):
		area.off() 
		delete()
		
	elif (area.is_in_group('player')):
		var hit = area.get_parent_node_3d()
		hit.die()
		delete()
		
	elif (area.is_in_group('beankill')):
		delete()
