extends Node2D

var off_texture = preload("res://assets/range_tile_off.png")
var on_texture = preload("res://assets/range_tile_on.png")
var blocks = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_value(value):
	for i in range(blocks.size()):
		if i < value:
			blocks[i].set_texture(on_texture)
		else:
			blocks[i].set_texture(off_texture)

func init(num_blocks, value):
	for i in range(num_blocks):
		var new_block = TextureFrame.new()
		self.add_child(new_block)
		new_block.set_owner(self)
		new_block.set_pos(Vector2(i * 25, 0))
		blocks.push_back(new_block)
	
	set_value(value)