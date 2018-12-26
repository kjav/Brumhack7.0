extends Node2D

var texture

func setTexture(newTexture):
	texture = newTexture
	get_node("KeyIcon").set_texture(texture)