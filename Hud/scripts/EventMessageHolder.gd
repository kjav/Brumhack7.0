extends Node2D

var EventMessage = load("res://Hud/EventMessage.tscn")

func _ready():
	GameData.player.connect("healthChanged", self, "PlayerHealthChanged")
	pass

func _on_Player_healthChanged(change, value):
	if(change == "Up"):
		addMessage('You healed: ' + str(value) + '.');

func _on_Player_itemPickedUp( item ):
		addMessage('You obtained a ' + item.name + '.');

func _on_Player_weaponChanged( slot, weapon ):
	if (slot == "Primary"):
		addMessage('A ' + weapon.name + ' is now equipt.');

func _on_Player_playerAttack( character, amount ):
	addMessage('You hurt a ' + character.name + ': ' + str(amount) + '.');

func _on_Enemy_attack( character, amount ):
	addMessage('A ' + character.name + ' hurt you: ' + str(amount) + '.');	

func _on_Timer_timeout(node):
	removeChild(node);

func createEventMessageNode(y_pos, text):
	var instance = EventMessage.instance();
	instance.set_pos(Vector2(0, y_pos));
	instance.set_text(text);
	instance.connect("timeout", self, "on_Timer_timeout");
	return instance;

func addMessage(text):
	var y_pos = 0;
	print ("number " + str(self.get_child_count()));
	#this number should be one less than wanted
	if(self.get_child_count() > 1):
		removeChild(0);
	if(self.get_child_count() > 0):
		y_pos = getLastYPosition();
	self.add_child(createEventMessageNode(y_pos, text));

func getLastYPosition():
	var y_pos = self.get_child(self.get_child_count()-1).get_pos().y;
	y_pos += self.get_child(self.get_child_count()-1).get_height();
	return y_pos;

func removeChild(child):
	if (TYPE_INT == typeof(child)):
		child = self.get_child(child)
	child.remove();
	self.remove_child(child);
	reposition(-child.get_height());

func reposition(height):
	for item in self.get_children():
		if item extends Node2D:
			item.set_pos(item.get_pos() + Vector2(0, height));

