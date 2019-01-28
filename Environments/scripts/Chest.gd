tool
extends "UnlockableBase.gd"

export(String, "closed", "open") var state = "closed" setget setState, getState

func _ready():
	Name = "Chest"

func changeOfState(original, new):
	return original != new

func setState(_state):
	if typeof(_state) == TYPE_STRING:
		if changeOfState(state, _state):
			state = _state
			self.set_animation(state)

func getState():
	return state

func keyUnlocked():
	#get item from a distribution
	#place item
	#remove chest
	base.keyUnlocked()