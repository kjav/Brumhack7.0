class BasicSword extends "Weapon.gd":	
	const texture = preload("res://assets/basic_sword.png")
	func _init():
		iconFilePath = "res://assets/basic_sword.png"
		name = "Basic Sword"
		distance = 1
		damage = 3
	
	func onUse():
		var a = 1

class BasicShield extends "Weapon.gd":
	const texture = preload("res://assets/basic_shield.png")
	func _init():
		iconFilePath = "res://assets/basic_shield.png"
		name = "Basic Shield"
		distance = 1
		damage = 1
	
	#todo, somehow needs to block damage or something
	func onUse():
		var b = 1
