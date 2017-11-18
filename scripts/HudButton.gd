tool
extends Node2D

export(int, "Right", "Centre", "Left") var frameStyle setget setFrameStyle, getFrameStyle
export(int, "Potion", "Food", "Spell") var type setget setType, getType

var leftFrame = preload("res://assets//frame_left.png")
var middleFrame = preload("res://assets//frame_none.png")
var rightFrame = preload("res://assets//frame_right.png")
var potion = preload("res://assets//potion_inventory.png")
var food = preload("res://assets//food_inventory2.png")
var spell = preload("res://assets//book1.png")

func _ready():
	pass

func setFrameStyle(style):
	if typeof(style) == typeof(0):
		frameStyle = style
		if frameStyle == 2:
			get_node("Background").set_texture(leftFrame)
		elif frameStyle == 1:
			get_node("Background").set_texture(middleFrame)
		elif frameStyle == 0:
			get_node("Background").set_texture(rightFrame)

func getFrameStyle():
	return frameStyle
	
func getType():
	return type

func setType(newType):
	if typeof(newType) == typeof(0):
		type = newType
		if type == 0:
			get_node("Icon").set_texture(potion)
		elif type == 1:
			get_node("Icon").set_texture(food)
		elif type == 2:
			get_node("Icon").set_texture(spell)