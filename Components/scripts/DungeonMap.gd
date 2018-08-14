tool
extends Node2D

export(int) var bottom_z_index = 0
export(int) var top_z_index = 2
export(int, "Basic Dungeon", "Maze Dungeon") var map_type = 0 setget set_map_type, get_map_type

var not_walkable = [-1, 6, 13, 21, 22, 23, 25, 26, 27, 28, 30, 32, 33, 34, 35]
var Pathfinder
var points = {}
var ids = {}
var map = null

class Map:
	var tiles = []
	func _init(width, height, type):
		if type == "DungeonMap":
			for i in range(0, 102):
				tiles.append([])
				for j in range(0, width):
					tiles[i].append(0)
			for i in range(102, 103):
				tiles.append([])
				for j in range(0, 100):
					tiles[i].append(0)
				for j in range(100, 113):
					tiles[i].append(6)
				for j in range(113, width):
					tiles[i].append(0)
			for i in range(103, 112):
				tiles.append([])
				for j in range(0, 100):
					tiles[i].append(0)
				for j in range(100, 101):
					tiles[i].append(6)
				for j in range(101, 112):
					tiles[i].append(0)
				for j in range(112, 113):
					tiles[i].append(6)
				for j in range(110, width):
					tiles[i].append(0)
			for i in range(112, 113):
				tiles.append([])
				for j in range(0, 100):
					tiles[i].append(0)
				for j in range(100, 113):
					tiles[i].append(6)
				for j in range(113, width):
					tiles[i].append(0)
			for i in range(113, height):
				tiles.append([])
				for j in range(0, width):
					tiles[i].append(0)
		elif type == "MazeMap":
			var cell_type = 1
			for i in range(0, height):
				tiles.append([])
				for j in range(0, width):
					tiles[i].append(cell_type)

var top_layer_tiles = []

func _ready():
	set_map_type(GameData.chosen_map)

func set_map_type(type):
	if has_node("BottomTileMap"):
		map = Map.new(200, 200, type)
		Pathfinder = AStar.new()
		GameData.tilemap = self
		
		var i = -100
		for row in map.tiles:
			var j = -100
			for tile in row:
				self.get_node("BottomTileMap").set_cell(i, j, tile)

				if tile in top_layer_tiles:
					self.get_node("TopTileMap").set_cell(i, j, tile)

				if !~not_walkable.find(tile):
					var id = Pathfinder.get_available_point_id()
					points[Vector3(i, j, 0)] = id
					ids[id] = Vector3(i, j, 0)
					Pathfinder.add_point(id, Vector3(i, j, 0))
					var point_left = Vector3(i-1, j, 0)
					var point_up = Vector3(i, j-1, 0)
					if points.has(point_left):
						Pathfinder.connect_points(id, points[point_left], true)
					if points.has(point_up):
						Pathfinder.connect_points(id, points[point_up], true)
				j = j + 1
			i = i + 1
	map_type = type

func get_map_type():
	return map_type

func walkable(x, y):
	var cell = self.get_node("BottomTileMap").get_cell(x, y)
	return !~not_walkable.find(cell)

func findPath(a, b):
	var a_vec3 = Vector3(a.x, a.y, 0)
	var b_vec3 = Vector3(b.x, b.y, 0)
	
	var a_id = points[a_vec3]
	var b_id = points[b_vec3]
	
	var id_path = Pathfinder.get_id_path(a_id, b_id)
	
	var path = []
	
	for id in id_path:
		var point_vec3 = ids[id]
		path.push_back(Vector2(point_vec3.x, point_vec3.y))
	
	return path

func findNextDirection(a, b):
	var a_vec3 = Vector3(a.x, a.y, 0)
	var b_vec3 = Vector3(b.x, b.y, 0)
	
	var a_id = points[a_vec3]
	var b_id = points[b_vec3]
	
	print("Before this")
	var id_path = Pathfinder.get_id_path(a_id, b_id)
	print(id_path)
	print("After this")
	
	var direction = Enums.DIRECTION.NONE
	
	if id_path.size() > 1:
		direction = ids[id_path[1]] - ids[id_path[0]]
		print(direction)
		if direction.x == 1:
			direction = Enums.DIRECTION.RIGHT
		elif direction.x == -1:
			direction = Enums.DIRECTION.LEFT
		elif direction.y == 1:
			direction = Enums.DIRECTION.DOWN
		elif direction.y == -1: