extends Area3D

@export var broken: bool = false

func _ready():
	if broken:
		off()

func off():
	$MeshInstance3D.visible = false
	position.y = 0
	collision_layer = 8
	broken = true

func on():
	$MeshInstance3D.visible = true
	position.y = -1
	collision_layer = 4
	broken = false
