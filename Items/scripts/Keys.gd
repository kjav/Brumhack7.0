class SilverKey extends "KeyBase.gd":
	const texture = preload("res://assets/silver_key.png")
	
	func _init():
		iconFilePath = "res://assets/silver_key.png"
		description = "A Silver Key"
		name = "Silver Key"
		UnlockGuid = "Silver"