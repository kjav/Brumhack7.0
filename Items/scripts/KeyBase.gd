extends "Item.gd"

var UnlockGuid
var ValidFloorNumber

func openUnlockableEnvronment(unlockableEnvironment):
	if UnlockGuid != null:
		if unlockableEnvironment.UnlockGuid == UnlockGuid:
			GameData.keys.remove(GameData.keys.find(self))
			unlockableEnvironment.keyUnlocked()

func setUnlockGuid(unlockGuid):
	UnlockGuid = unlockGuid

func setValidFloorNumber(validFloorNumber):
	ValidFloorNumber = validFloorNumber

func pickup():
	GameData.addKey(self)
	.pickup()