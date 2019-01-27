extends "UnlockableBase.gd"

export(String, "side", "front") var facing = "front" setget setFacing, getFacing
export(String, "closed", "open") var state = "closed" setget setState, getState

func _ready():
	Name = "Door"

func handleDoorAnimation():
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
			handleDoorAnimation()
			if get_node("Locks") != null:
				get_node("Locks").set_animation(facing + "_locked")

func getFacing():
	return facing

func setState(_state):
	if typeof(_state) == TYPE_STRING:
		if changeOfState(state, _state):
			state = _state
			handleDoorAnimation()

func getState():
	return state

func reset():
	setFacing(facing)
	setLocked(locked)

func onWalkedInto(character):
	if !locked:
		state = "open"
		handleDoorAnimation()
	elif character == GameData.player:
		var key = GameData.HasKey(UnlockGuid)
		
		if key != null:
			keyUnlocked()