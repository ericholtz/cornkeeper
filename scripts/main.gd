extends Node3D

@onready var item_ui = $UI/ItemScreen
@onready var player = $Player
@onready var door_1: CSGBox3D = $Level/Door1
@onready var door_2: CSGBox3D = $Level/Door2


var item_ui_active: bool = false
var current_item: Node3D = null
var items_total: int = 0
var items_collected: int = 0

func _ready() -> void:
	# connect all item signals to this script
	for item in get_node("Items").get_children():
		items_total += 1
		item.connect("item_pickup", Callable(_on_item_pickup))
	
func _process(_delta: float) -> void:
	# once the player has exited the UI
	if item_ui_active and Input.is_action_just_pressed("enter"):
		show_item_ui(false)
		player.enable()
		
		current_item.remove()
		items_collected += 1
		print("Items collected: ", items_collected)
		if items_collected >= items_total:
			open_door1()
	
func _on_item_pickup(item, item_image, flavor_text):
	# set flavor text and image
	var texture_rect = item_ui.get_node("HBoxContainer/TextureRect")
	var flavor_label = item_ui.get_node("HBoxContainer/Label")
	texture_rect.texture = item_image
	flavor_label.text = flavor_text
	
	current_item = item
	player.disable()
	show_item_ui(true)

func show_item_ui(toggle):
	item_ui.visible = toggle
	item_ui_active = toggle
	var player = item_ui.get_node("textflash")
	if toggle:
		player.play("textflash")
	else:
		player.stop()

func open_door1():
	var tween = create_tween()
	tween.tween_property(door_1, "position", door_1.position + Vector3(4, 0, 0), 5)
	tween.play()
