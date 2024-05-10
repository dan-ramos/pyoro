extends Area3D

@export var broken: bool = false

func on():
	$MeshInstance3D.visible = true
	position.y = -1
	collision_layer = 4
	broken = false
