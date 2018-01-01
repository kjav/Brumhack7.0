extends "Item.gd"

const texture = preload("res://assets/red_potion2.png")

func _ready():
	iconFilePath = "res://assets/red_potion2.png"
	description = "This drink heal your wounds!"
	name = "Health Potion"

func onUse():
	if (GameData.player.health < GameData.player.maxHealth):
		GameData.player.health += 1
	GameData.potion.remove(self)	
	emit_signal("healthChanged", "Up", 1)
	#this signal is not connected yet