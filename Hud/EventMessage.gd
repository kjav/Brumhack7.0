extends Node2D

func _ready():
	get_node("Timer").start();

func set_text(text):
	get_node("Output").set_text(text);
	

func _on_Timer_timeout():
	
	hide();
	queue_free(); 
	get_parent().remove_child(self)
