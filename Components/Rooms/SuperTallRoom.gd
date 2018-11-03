extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(4, 12)])
	npc_distribution = NumberOf.new({"n": 2, "value": load("res://Characters/Bat.tscn")})
	environment_distribution = Distribution.new([])
	item_distribution = Distribution.new([])