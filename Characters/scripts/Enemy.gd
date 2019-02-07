extends "Character.gd"

var attack
var name = 'Unset'

func _ready():
	set_process(true)
	GameData.characters.append(self)
	self.get_node("/root/Node2D").connectEnemy(self)

func attack(character):
	.attack(character, roll_damage());
	
func turn():
	pass

func _process(delta):
	pass