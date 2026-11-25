extends Node

#system for spawning scene objects across the map
#written by truman, 11/22/2026

func spawn_objects(scene_object, amount, parent, y_placement, can_clip_with_mountains, plr_pos):
	
	var x_max: float
	var x_placement
	var z_placement
	var no_crash = 0
	
	#spawn 100 mopre bushes at random positons on the map
	if can_clip_with_mountains:
		x_max = 89.245
	else:
		x_max = 66.259
	
	for i in range(amount):
		if plr_pos:
				x_placement = randf_range(-12.324, x_max)
				z_placement = randf_range(-59.235, 59.167)
				
				if (x_placement > plr_pos.x + 10 and x_placement < plr_pos.x - 10 and
				   y_placement > plr_pos.z + 10 and z_placement < plr_pos.z - 10) or no_crash >= 100:
					pass
				no_crash + 1
		else:
			x_placement = randf_range(-12.324, x_max)
			z_placement = randf_range(-59.235, 59.167)
	
		var object_clone = scene_object.instantiate() # Replace with function body.

		object_clone.position = Vector3(x_placement, y_placement, z_placement)
	
		parent.add_child(object_clone)
		
