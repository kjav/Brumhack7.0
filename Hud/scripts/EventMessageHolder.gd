extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	GameData.player.connect("healthChanged", self, "PlayerHealthChanged")
	pass

func PlayerHealthChanged(change, value):
	print("hp changed")
	if(change == "Up"):
		addMessage("Player was healed: " + value);
	else:
		addMessage("Player was hurt: " + value);

func addMessage(text):
	get_node("Output").add_text(text);