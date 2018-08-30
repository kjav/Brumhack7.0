extends Node2D

func _ready():
	get_node("FloorItems").setupConnection()
	connectEnemies()

func connectEnemies():
	for child in get_node("Enemies").get_children():
		child.connect("attack", get_node("HudNode"), "_on_Enemy_attack")