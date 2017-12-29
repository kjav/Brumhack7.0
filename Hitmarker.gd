extends Node2D


var amount setget setAmount, getAmount

func setAmount(newAmount):
	if typeof(newAmount) == TYPE_INT:
		amount = newAmount
		get_node("Amount").set_text(str(amount))

func getAmount():
	return amount
	
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