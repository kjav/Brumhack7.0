extends "Character.gd"

signal attack(character, amount)

var attack
var name = 'Unset'


func _ready():
	set_process(true)
	GameData.characters.append(self)

func attack(character):
	emit_signal("attack", self, damage);
	.attack(character, damage);
	
func turn():
	pass

func _process(delta):
	pass