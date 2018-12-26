extends "EnvironmentBase.gd"

export(bool) var locked = true setget setLocked, getLocked
var UnlockGuid

func setLocked(_locked):
	if typeof(_locked) == TYPE_BOOL:
		locked = _locked
		walkable = !locked
		emitSignal(true)
		if get_node("Locks") != null:
			get_node("Locks").set_hidden(!locked)

func getLocked():
	return locked

func setUnlockGuid(unlockGuid):
	UnlockGuid = unlockGuid