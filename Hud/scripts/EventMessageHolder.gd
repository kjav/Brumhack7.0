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

func _on_Timer_timeout():
	var child = self.get_child(1);
	var height = child.get_height();
	child._on_Timer_timeout();
	self.remove_child(child);
	#does this leave the timer alive? or does oneshot mean it removes
	reposition(height);
	

func addMessage(text):
	var instance = EventMessage.instance();
	var timer = Timer.new();
	timer.set_wait_time(5);
	timer.connect("timeout", self, "_on_Timer_timeout");
	timer.start();
	self.get_child(0).add_child(timer);
	var y_pos = 0;
	if(self.get_child_count() > 5):
		reposition(self.get_child(1).get_height());
		self.remove_child(1);
	elif(self.get_child_count() > 1):
		y_pos = self.get_child(self.get_child_count()-1).get_pos().y;
		y_pos += self.get_child(self.get_child_count()-1).get_height();
	instance.set_pos(Vector2(0, y_pos));
	instance.set_text(text);
	self.add_child(instance);

func reposition(height):
	for item in self.get_children():
		if item extends Node2D:
			item.set_pos(item.get_pos() + Vector2(0, height));

