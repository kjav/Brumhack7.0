extends "Item.gd"

var UnlockGuid
var ValidFloorNumber

func onUse():
	#If adjecent to unlockable Environment with the same guid - this may not be needed as will probably save key in a door.
	#	openDoor(unlockableEnvironment) 
	pass

func openUnlockableEnvronment(unlockableEnvironment):
	if UnlockGuid != null:
		if unlockableEnvironment.UnlockGuid == UnlockGuid:
			#remove key
			unlockableEnvironment.setLocked(false)

func setUnlockGuid(unlockGuid):
	UnlockGuid = unlockGuid

func setValidFloorNumber(validFloorNumber):
	ValidFloorNumber = validFloorNumber