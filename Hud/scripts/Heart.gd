extends Node2D

export(int, "Full", "Empty") var type setget setType, getType


var full = preload("res://assets/heart.png")
var empty = preload("res://assets/grey_heart.png")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func setType(newType):
	type = newType
	if type == "Full":
		get_node("Heart").set_texture(full)
	elif type == "Empty":
		get_node("Heart").set_texture(empty)

func getType():
	return type
