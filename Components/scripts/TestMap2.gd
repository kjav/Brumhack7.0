extends "MapBase.gd"

func _init(n_rooms).(200, 200, 0):
	
	var tree = load("res://Components/scripts/SurroundingsTree.gd").new(10)
	print("Tree: ")
	tree.add_value([
		null, true, null,
		false, true, false,
		null, false, null, null
	], 42)
	
	var start = OS.get_ticks_msec()
	print("    Fill Time: ", OS.get_ticks_msec() - start)
	var rooms = [{
		"name": "main",
		"extents": [
			Vector2(103, 104), Vector2(109, 104), Vector2(109, 110), Vector2(103, 110)
		]
	}]
	
	wall([Vector2(103, 104), Vector2(109, 104), Vector2(109, 110), Vector2(103, 110), Vector2(103, 104)])
	
	var exterior_walls = []
	
	for i in range(0, 3):
		exterior_walls.push_back([rooms[0].extents[i], rooms[0].extents[(i + 1) % 4]])
	
	# TODO: Remove
	seed(13337)
	
	var mid_1 = OS.get_ticks_msec()

	var i = 0;
	while rooms.size() < n_rooms + 1:
		# Pick a wall
		var wall_index = randi() % exterior_walls.size()
		var wall = exterior_walls[wall_index]
		if true:
			print("Chosen wall: ", wall)
			exterior_walls.remove(wall_index)
			var wall_direction = (wall[1] - wall[0]).normalized()
			var out_direction = wall_direction.rotated(PI / 2)
			var in_direction = wall_direction.rotated(3 * PI / 2)
			var wall_length = int((wall[1] - wall[0]).length())
			var joint_index = 1 + (randi() % ( - 2))
			var joint = joint_index * wall_direction + wall[0]
			remove_wall([joint, joint])
			var room = {
				"name": str(i),
				"extents": [wall[0], wall[0] + out_direction * 6, wall[1] + out_direction * 6, wall[1]]
			}
			wall(room.extents)
			rooms.push_back(room)
			i = i + 1
			for i in range(0, 2):
				exterior_walls.push_back([room.extents[i], room.extents[i + 1]])
	
	var mid_2 = OS.get_ticks_msec()
	print("    Rooms time: ", OS.get_ticks_msec() - mid_1)
	
	make_walls_consistent()
	print("    Make walls consistent time: ", OS.get_ticks_msec() - mid_2)
	
	print("Total Time: ", OS.get_ticks_msec() - start)