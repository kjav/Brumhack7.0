tool
extends Node2D

export(int) var bottom_z_index = 0
export(int) var top_z_index = 2
export(int, "Basic Dungeon", "Maze Dungeon") var map_type = 0 setget set_map_type, get_map_type

var TestMap = load("res://Components/scripts/TestMap2.gd")

var not_walkable = [-1, 6, 13, 21, 22, 23, 25, 26, 27, 28, 30, 32, 33, 34, 35, 39, 41, 42]
var flat_not_walkable = []

var Pathfinder
var points = {}
var ids = {}
var map = null

var top_layer_tiles = []

var BottomTileMap

func _ready():
	BottomTileMap = get_node("BottomTileMap")
	map = TestMap.new(40)
	for i in range(0, 128):
		flat_not_walkable.push_back(not_walkable.has(i))
	set_map_type(GameData.chosen_map)

func set_map_type(type):
	if has_node("BottomTileMap"):
		var BTM = self.get_node("BottomTileMap")
		var TTM = self.get_node("BottomTileMap")
		Pathfinder = AStar.new()
		GameData.tilemap = self
		
		var j = -100
		for row in map.tiles:
			var i = -100
			for tile in row:
				BTM.set_cell(i, j, tile)

				if tile in top_layer_tiles:
					TTM.set_cell(i, j, tile)

				if !flat_not_walkable[tile]:
					var vec = Vector3(i, j, 0)
					var id = Pathfinder.get_available_point_id()
					points[vec] = id
					ids[id] = vec
					Pathfinder.add_point(id, vec)
					var point_left = Vector3(i-1, j, 0)
					var point_up = Vector3(i, j-1, 0)
					if points.has(point_left):
						Pathfinder.connect_points(id, points[point_left], true)
					if points.has(point_up):
						Pathfinder.connect_points(id, points[point_up], true)
				i = i + 1
			j = j + 1
	map_type = type

func get_map_type():
	return map_type

func walkable(x, y):
	var cell = BottomTileMap.get_cell(x, y)
	return !not_walkable.has(cell)

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
	
	print("Getting id path ", a_vec3, ", ", b_vec3)
	
	var id_path = Pathfinder.get_id_path(a_id, b_id)
	
	print("Got id path ", a_vec3, ", ", b_vec3, ". Length: ", id_path.size())
	
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
			direction = Enums.DIRECTION.UP
	return direction