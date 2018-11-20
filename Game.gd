extends Node2D

func _ready():
	get_node("FloorItems").setupConnection()
	get_node("Environements/Door").setLocked(true)
	get_node("Environements/Door").setFacing("front")
	
	connectEnemies()

func connectEnemies():
	for child in get_node("Enemies").get_children():
		child.connect("attack", get_node("HudNode"), "_on_Enemy_attack")