tool
extends Sprite

export(String, "Side", "Front") var facing setget setFacing, getFacing
export(bool) var locked setget setLocked, getLocked

var frontDoor = preload("res://assets//floor_tiles/door_front_whole.png")
var sideDoor = preload("res://assets//floor_tiles/door_side.png")
var frontLock = preload("res://assets//floor_tiles/door_front_whole_locks.png")
var sideLock = preload("res://assets//floor_tiles/door_side_locks.png")

func setFacing(_facing):
	if typeof(_facing) == TYPE_STRING:
		if changeOfState(facing, _facing):
			facing = _facing
			if facing == "Side":
				self.set_texture(sideDoor)
				self.set_pos(self.get_pos() + Vector2(0,16))
					
				if get_node("Locks") != null:
					get_node("Locks").set_texture(sideLock)
			elif facing == "Front":
				self.set_texture(frontDoor)
				self.set_pos(self.get_pos() - Vector2(0,16))
				
				if get_node("Locks") != null:
					get_node("Locks").set_texture(frontLock)

func changeOfState(original, new):
	return original != new

func getFacing():
	return facing
	
func setLocked(_locked):
	if typeof(_locked) == TYPE_BOOL:
		locked = _locked
		if get_node("Locks") != null:
			get_node("Locks").set_hidden(locked)

func getLocked():
	return locked

func reset():
	setFacing(facing)
	setLocked(locked)