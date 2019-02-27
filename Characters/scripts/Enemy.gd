extends "Character.gd"

var attack
var name = 'Unset'
var base_damage = 1

func _ready():
	set_process(true)
	GameData.characters.append(self)
	self.get_node("/root/Node2D").connectEnemy(self)

func attack(character):
	.attack(character, base_damage);
	
func turn():
	pass

func _process(delta):
	pass