class BasicSword extends "Weapon.gd":	
	const texture = preload("res://assets/basic_sword.png")
	func _init():
		iconFilePath = "res://assets/basic_sword.png"
		name = "Basic Sword"
		distance = 1
		damage = 1
	
	func onUse():
		break

class BasicShield extends "Weapon.gd":
	const texture = preload("res://assets/basic_shield.png")
	func _init():
		iconFilePath = "res://assets/basic_shield.png"
		name = "Basic Shield"
		distance = 1
		damage = 1
	
	#todo, somehow needs to block damage or something
	func onUse():
		break