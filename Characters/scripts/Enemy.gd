extends "Character.gd"

var attack
var name = 'Unset'

func _ready():
	set_process(true)
	GameData.characters.append(self)

func attack(character):
	.attack(character, damage);
	
func turn():
	pass

func _process(delta):
	pass