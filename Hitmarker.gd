extends Node2D


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var timer = Timer.new()
	timer.set_wait_time(1)
	timer.connect("timeout",self,"Timeout") 
	timer.set_one_shot(true)
	add_child(timer)
	timer.start()
	pass

func Timeout():
	print("out of time")
	self.queue_free()
	self.hide()