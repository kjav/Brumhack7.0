extends "MapBase.gd"

func _init(n_rooms).(200, 200):
	fill(0)
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
	
	make_walls_consistent()
	#for  i in range(0, n_rooms):
	#	wall([Vector2(95, 90), Vector2(95, 110), Vector2(115, 110)])
	#	wall([Vector2(104, 107), Vector2(104, 113)])
	#	wall([Vector2(95, 104), Vector2(98, 104), Vector2(98, 110)])