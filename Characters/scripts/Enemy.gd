extends "Character.gd"


var Distribution = load("res://Components/Distributions/IndependentDistributions.gd")

var attack
var name = 'Unset'
var item_distribution

func _ready():
	set_process(true)
	GameData.characters.append(self)
	self.get_node("/root/Node2D").connectEnemy(self)

func attack(character):
	.attack(character, damage);
	
func turn():
	pass

func _process(delta):
	pass

func handleCharacterDeath():
	dropItem()

	.handleCharacterDeath()

func dropItem():
	if(item_distribution != null):
		for pickedItem in item_distribution.pick():
			var item = pickedItem.new()
			item.place(get_pos())