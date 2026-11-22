extends Node

#system for spawning scene objects across the map
#written by truman, 11/22/2026

func spawn_objects(scene_object, amount, parent, y_placement, can_clip_with_mountains):
	
	var x_max: float
	
	#spawn 100 mopre bushes at random positons on the map
	if can_clip_with_mountains:
		x_max = 89.245
	else:
		x_max = 66.259
	
	for i in range(amount):
		var object_clone = scene_object.instantiate() # Replace with function body.

		object_clone.position = Vector3(randf_range(-12.324, x_max),y_placement,randf_range(-59.235, 59.167))
	
		parent.add_child(object_clone)
		
