extends "EnvironmentBase.gd"

func _ready():
	walkable = true

func onWalkedInto(character):
	if character == GameData.player:
		self.animation = "active"
		character.takeDamage(1)
		character.takeDamage(0.5)
		character.takeDamage(0.5)
		character.takeDamage(0.5)
		character.takeDamage(0.5)
		character.takeDamage(0.5)
		character.takeDamage(0.5)
		character.takeDamage(0.5)