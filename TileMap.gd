extends TileMap

var not_walkable = [-1, 6, 13, 21, 22, 23, 25, 26, 27]

func _ready():
	GameData.tilemap = self

func walkable(x, y):
	var cell = self.get_cell(x, y)
	return !~not_walkable.find(cell)