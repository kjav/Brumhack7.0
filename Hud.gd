extends Node2D

var inventoryOpen
var inc = 40

const Heart = preload("res://Heart.tscn")

func _ready():
	inventoryOpen = false


func PlayerHealthChange(change, value):
	var health = GameData.player.health
	
	for i in range(health):
		var new_node = Heart.instance()
		new_node.setType("Full")
		new_node.set_pos(Vector2(inc*i, 0))
		get_node("HudCanvasLayer/HealthBar").add_child(new_node)
	