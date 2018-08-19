extends Node2D

func set_text(text):
	get_node("Output").set_text(text);

func get_height():
	return get_node("Output").get_size().y * get_node("Output").get_scale().y;

func _on_Timer_timeout(): 
	hide();
	queue_free(); 
