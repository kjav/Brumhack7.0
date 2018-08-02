class BasicSword extends "Weapon.gd":	
	const texture = preload("res://assets/basic_sword.png")
	func _init():
		iconFilePath = "res://assets/basic_sword.png"
		name = "Basic Sword"
		distance = 1
		damage = 3
		holdOffset = [Vector2(13,27), Vector2(33,27), Vector2(22,27), Vector2(26,27)]
	
	func onUse():
		var a = 1



class BasicShield extends "Weapon.gd":
	const texture = preload("res://assets/basic_shield.png")
	func _init():
		iconFilePath = "res://assets/basic_shield.png"
		name = "Basic Shield"
		distance = 1
		damage = 1
		holdOffset = [Vector2(32,27), Vector2(15,29), Vector2(24,27), Vector2(24,27)]
	
	
	#todo, somehow needs to block damage or something
	func onUse():
		var b = 1
