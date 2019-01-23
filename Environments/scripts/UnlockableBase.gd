extends "EnvironmentBase.gd"

signal keyUsed(unlockGuid, unlockedObjectsName)

export(bool) var locked = true setget setLocked, getLocked
var UnlockGuid

func _ready():
	self.get_node("/root/Node2D").connectUnlockableEnvironment(self)

func setLocked(_locked):
	if typeof(_locked) == TYPE_BOOL:
		locked = _locked
		walkable = !locked
		if get_node("Locks") != null:
			get_node("Locks").set_hidden(!locked)
		if !locked:
			GameData.RemoveKey(unlockGuid)
			emit_signal("keyUsed", UnlockGuid, Name)

func getLocked():
	return locked

func setUnlockGuid(unlockGuid):
	UnlockGuid = unlockGuid