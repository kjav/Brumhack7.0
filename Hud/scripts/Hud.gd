extends Node2D

var inventoryOpen
var settingsOpen
var inc = 40

const Heart = preload("res://Hud/Heart.tscn")

func _ready():
	inventoryOpen = false
	settingsOpen = false
	PlayerHealthChanged("", 0)
	GameData.player.connect("healthChanged", self, "PlayerHealthChanged")
	GameData.player.connect("weaponChanged", self, "PlayerWeaponChanged")
	GameData.player.connect("playerMove", self, "CheckFloor")
	get_node("HudCanvasLayer/SpellInvent/front").connect("InventoryOpened", self, "SpellInventoryOpened")
	get_node("HudCanvasLayer/PotInvent/front").connect("InventoryOpened", self, "PotInventoryOpened")
	get_node("HudCanvasLayer/FoodInvent/front").connect("InventoryOpened", self, "FoodInventoryOpened")
	get_node("HudCanvasLayer/Pickup").hide()

func FoodInventoryOpened(inventory):
	inventory.connect("ItemUsed", get_node("HudCanvasLayer/EventMessageHolder"), "_on_FoodItem_used")
func SpellInventoryOpened(inventory):
	inventory.connect("ItemUsed", get_node("HudCanvasLayer/EventMessageHolder"), "_on_SpellItem_used")
func PotInventoryOpened(inventory):
	inventory.connect("ItemUsed", get_node("HudCanvasLayer/EventMessageHolder"), "_on_PotItem_used")

func CheckFloor(pos):
	if GameData.itemAtPos(pos):
		get_node("HudCanvasLayer/Pickup").show()
	else:
		get_node("HudCanvasLayer/Pickup").hide()

func PlayerWeaponChanged(slot, weapon):
	var selectedSlot
	if slot == "Primary":
		selectedSlot = get_node("HudCanvasLayer/PrimaryWeaponSlot")
	else:
		selectedSlot = get_node("HudCanvasLayer/SecondaryWeaponSlot")
	selectedSlot.setIconTexture(weapon.texture)

func PlayerHealthChanged(change, value):
	for child in get_node("HudCanvasLayer/HealthBar").get_children():
		child.queue_free()
		child.hide()
	var health = GameData.player.health
	var maxHealth = GameData.player.maxHealth
	for i in range(maxHealth):
		var new_node = Heart.instance()
		new_node.set_pos(Vector2(inc*i, 0))
		if (i < health):
			new_node.setType("Full")
		else:
			new_node.setType("Empty")
		
		get_node("HudCanvasLayer/HealthBar").add_child(new_node)
	
	if health <= 0:
		get_node("HudCanvasLayer/DeathMenu").died()

func _on_Player_itemPickedUp( item ):
	get_node("HudCanvasLayer/EventMessageHolder")._on_Player_itemPickedUp(item);
func _on_Player_weaponChanged( slot, weapon ):
	get_node("HudCanvasLayer/EventMessageHolder")._on_Player_weaponChanged(slot, weapon);
func _on_Player_playerAttack( character, amount ):
	get_node("HudCanvasLayer/EventMessageHolder")._on_Player_playerAttack(character, amount);
func _on_Enemy_attack( character, amount ):
	get_node("HudCanvasLayer/EventMessageHolder")._on_Enemy_attack(character, amount);
func _on_Player_healthChanged( change, value ):
	get_node("HudCanvasLayer/EventMessageHolder")._on_Player_healthChanged(change, value);