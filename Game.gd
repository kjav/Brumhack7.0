extends Node2D

func _ready():
	get_node("FloorItems").setupConnection()
	pass


func _on_Enemy_attack( character, amount ):
	pass # replace with function body
