extends 'RoomBase.gd'

func setup_params():
	extents_distribution = Set.new([Vector2(7, 4)])
	npc_distribution = Distribution.new([{"p": 0.4, "value": load("res://Characters/Bat.tscn")}])
	environment_distribution = Distribution.new([])
	item_distribution = Distribution.new([{"p": 1, "value": KeyClasses.SilverKey}])