extends Node2D

func _ready():
	get_node("FloorItems").setupConnection()
	
	connectEnemies()
	connectEnvironmentToPathfinding()
	
	get_node("Environments/Door").setLocked(true)
	get_node("Environments/Door").setFacing("front")

func connectEnemies():
	for child in get_node("Enemies").get_children():
		child.connect("attack", get_node("HudNode"), "_on_Enemy_attack")

func connectEnvironmentToPathfinding():
	for child in get_node("Environments").get_children():
		child.connect("blockStateChanged", get_node("DungeonMap"), "_on_Environment_blockStateChanged")