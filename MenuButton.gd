tool
extends Node2D

export(String) var text setget setText, getText
export(PackedScene) var scene setget setScene, getScene

func _ready():
	get_node("MenuButtonLabel").set("text", text)

func setText(t):
	text = t
	if is_inside_tree() and get_tree().is_editor_hint():
		get_node("MenuButtonLabel").set("text", text)

func getText():
	return text

func setScene(s):
	scene = s

func getScene():
	return scene

func pressed():
	if scene:
		get_tree().change_scene(scene.get_path())