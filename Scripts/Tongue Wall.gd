extends Area3D

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	area.get_parent_node_3d().retract()
