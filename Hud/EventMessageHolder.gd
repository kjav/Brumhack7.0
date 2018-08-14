extends Node2D

var EventMessage = load("res://Hud/EventMessage.tscn")

func _ready():
	GameData.player.connect("healthChanged", self, "PlayerHealthChanged")
	pass

func _on_Player_healthChanged(change, value):
	print("hp changed")
	if(change == "Up"):
		addMessage('Player was healed: ' + str(value));
	else:
		addMessage('Player was hurt: ' + str(value));

func addMessage(text):
	var instance = EventMessage.instance()
	instance.set_text(text);
	get_tree().get_root().add_child(instance);