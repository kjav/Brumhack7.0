extends "Item.gd"

const texture = preload("res://assets/red_potion2.png")

func _ready():
	iconFilePath = "res://assets/red_potion2.png"
	description = "This drink heal your wounds!"
	name = "Health Potion"

func onUse():
	GameData.player.heal(1)
	print("potion consumed")
	GameData.potions.remove(GameData.potions.find(self))