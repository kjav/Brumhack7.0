const missile = preload("res://Characters/Missile.tscn")
const missile_texture = preload("res://assets/fireball.png")

class FireSpell extends "Item.gd":
	const texture = preload("res://assets/red_spell2.png")
	
	func _init():
		iconFilePath = "res://assets/red_spell2.png"
		description = "Shoot a fire ball at the closest enemy!"
		name = "Fire Spell"

	func onUse():
		var closest_enemy = GameData.closestEnemy()
		if closest_enemy:
			closest_enemy.takeDamage(1)
			# Remove potion
			GameData.spells.remove(GameData.spells.find(self))
			
			# Launch a fireball
			var new_missile = missile.instance()
			GameData.player.get_parent().add_child(new_missile)
			new_missile.init(
				closest_enemy.get_path(),
				missile_texture,
				GameData.player.get_pos(),
				25,
				10
			)

	func pickup():
		#todo, needs to check if inventory is full first
		GameData.addSpells([self])
		.pickup()