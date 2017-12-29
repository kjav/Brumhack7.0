extends Node2D

var inventoryOpen
var inc = 40

const Heart = preload("res://Heart.tscn")

func _ready():
	inventoryOpen = false
	PlayerHealthChanged("", 0)
	GameData.player.connect("healthChanged", self, "PlayerHealthChanged")


func PlayerHealthChanged(change, value):
	for child in get_node("HudCanvasLayer/HealthBar").get_children():
		child.queue_free()
		child.hide()
	var health = GameData.player.health
	var maxHealth = GameData.player.maxHealth
	for i in range(maxHealth):
		var new_node = Heart.instance()
		new_node.set_pos(Vector2(inc*i, 0))
		if (i < health):
			new_node.setType("Full")
		else:
			new_node.setType("Empty")
		
		get_node("HudCanvasLayer/HealthBar").add_child(new_node)
	