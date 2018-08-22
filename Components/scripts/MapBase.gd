var tiles = []

func is_wall(tile):
	return tile in [6, 13, 21, 28, 30, 32, 33, 34, 35, 39]
	
func _init(width, height):
	for j in range(0, height):
		tiles.push_back([])
		for i in range(0, width):
			tiles[j].push_back(-1)

# Fill the map with 1 tile type
func fill(tile):
	for j in range(0, tiles.size()):
		for i in range(0, tiles[j].size()):
			tiles[j][i] = tile

# Does the 9-tile surrounding area match the template?
func match(tiles, template):
	for i in range(0, tiles.size()):
		if template[i] != null:
			if tiles[i] != template[i]:
				return false
	return true

# Does the 9-tile surrounding area match any of the templates?
func match_any(tiles, templates):
	for template in templates:
		if match(tiles, template):
			return true
	return false

# Create a wall between the given points
func wall(path):
	var path_size = path.size()
	var changed_tiles = {}
	if path_size == 0:
		return
	if path_size == 1:
		var point = path[0]
		tiles[point[1]][point[0]] = 6
	else:
		for index in range(0, path.size() - 1):
			var point_a = path[index]
			var point_b = path[index + 1]
			var diff = point_b - point_a
			var move = Vector2(0, 0)
			if diff[0] == 0 and diff[1] != 0:
				# Moving vertically
				move.y = diff[1] / abs(diff[1])
			elif diff[0] != 0 and diff[1] == 0:
				# Moving horizontally
				move.x = diff[0] / abs(diff[0])
			else:
				print("Error: wall path contains a diagonal line.")
				return
			
			while point_a != point_b:
				tiles[point_a.y][point_a.x]  = 6
				changed_tiles[point_a] = true
				changed_tiles[point_a + Vector2(1, 0)] = true
				changed_tiles[point_a + Vector2(-1, 0)] = true
				changed_tiles[point_a + Vector2(0, 1)] = true
				changed_tiles[point_a + Vector2(0, -1)] = true
				point_a += move
		var point = path[-1]
		tiles[point.y][point.x] = 6
		changed_tiles[point] = true
		changed_tiles[point + Vector2(1, 0)] = true
		changed_tiles[point + Vector2(-1, 0)] = true
		changed_tiles[point + Vector2(0, 1)] = true
		changed_tiles[point + Vector2(0, -1)] = true
	# Make walls consistent
	print(changed_tiles.keys())
	for point in changed_tiles:
		# If point in map
		if true:
			# Get the 9 tiles affecting the display of this tile
			var surroundings = [
				point + Vector2(-1, -1), point + Vector2(0, -1), point + Vector2(1, -1),
				point + Vector2(-1, 0), point + Vector2(0, 0), point + Vector2(1, 0),
				point + Vector2(-1, 1), point + Vector2(0, 1), point + Vector2(1, 1)
			]
			for i in range(0, surroundings.size()):
				surroundings[i] = is_wall(tiles[surroundings[i].y][surroundings[i].x])
			
			# Vertical wall
			if match(surroundings, [
				null, null, null,
				false, true, false,
				null, true, null
			]):
				tiles[point.y][point.x] = 21
			
			# Horizontal wall endings
			if match(surroundings, [
				null, false, null,
				true, true, false,
				null, false, null
			]):
				tiles[point.y][point.x] = 34
			elif match(surroundings, [
				null, false, null,
				false, true, true,
				null, false, null
			]):
				tiles[point.y][point.x] = 32
			
			# Horizontal wall endings with wall above
			if match(surroundings, [
				null, true, null,
				false, true, true,
				null, false, null
			]):
				tiles[point.y][point.x] = 32
			if match(surroundings, [
				null, true, null,
				true,  true, false,
				null, false, null
			]):
				tiles[point.y][point.x] = 34 
			
			# Horizontal wall endings with wall below
			if match(surroundings, [
				null, false, null,
				false, true, true,
				null, true, null
			]):
				tiles[point.y][point.x] = 28
			if match(surroundings, [
				null, false, null,
				true, true, false,
				null, true, null
			]):
				tiles[point.y][point.x] = 30
				
			# Above horizontal wall
			if match(surroundings, [
				null, null, null,
				null, false, null,
				true, true, false
			]):
				tiles[point.y][point.x] = 31
			elif match(surroundings, [
				null, null, null,
				null, false, null,
				false, true, true
			]):
				tiles[point.y][point.x] = 29
			elif match(surroundings, [
				null, false, null,
				null, false, null,
				true, true, true
			]):
				tiles[point.y][point.x] = 14
			
			
			# Horizontal 1 way meets vertical 2 ways
			if match(surroundings, [
				null, true, null,
				false, true, true,
				null, true, null
			]):
				tiles[point.y][point.x] = 28
			elif match(surroundings, [
				null, true, null,
				true, true, false,
				null, true, null
			]):
				tiles[point.y][point.x] = 30
			
			# L shapes
			if match(surroundings, [
				null, null, null,
				false, true, false,
				false, true, true
			]):
				tiles[point.y][point.x] = 33
			elif match(surroundings, [
				null, null, null,
				false, true, false,
				true, true, false
			]):
				tiles[point.y][point.x] = 35
			elif match(surroundings, [
				null, null, null,
				false, true, false,
				true, true, true
			]):
				tiles[point.y][point.x] = 39