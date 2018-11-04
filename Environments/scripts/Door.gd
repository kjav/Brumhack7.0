tool
extends AnimatedSprite

export(String, "side", "front") var facing = "front" setget setFacing, getFacing
export(String, "closed", "open") var state = "closed" setget setState, getState
export(bool) var locked = true setget setLocked, getLocked

func setDoorAnimation():
	self.set_animation(facing + "_" + state)

func changeOfState(original, new):
	return original != new

func setFacing(_facing):
	if typeof(_facing) == TYPE_STRING:
		if changeOfState(facing, _facing):
			facing = _facing
			if facing == "side":
				self.set_pos(self.get_pos() + Vector2(0,16))
			elif facing == "front":
				self.set_pos(self.get_pos() - Vector2(0,16))
			setDoorAnimation()
			if get_node("Locks") != null:
				get_node("Locks").set_animation(facing + "_locked")

func getFacing():
	return facing

func setState(_state):
	if typeof(_state) == TYPE_STRING:
		if changeOfState(state, _state):
			state = _state
			setDoorAnimation()

func getState():
	return state

func setLocked(_locked):
	if typeof(_locked) == TYPE_BOOL:
		locked = _locked
		if get_node("Locks") != null:
			get_node("Locks").set_hidden(!locked)

func getLocked():
	return locked

func reset():
	setFacing(facing)
	setLocked(locked)