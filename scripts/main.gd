extends Node3D

@onready var item_ui = $UI/ItemScreen
@onready var player = $Player
var item_ui_active: bool = false

func _ready() -> void:
	# connect all item signals to this script
	for item in get_node("Items").get_children():
		item.connect("item_pickup", Callable(_on_item_pickup))
	
func _process(delta: float) -> void:
	if item_ui_active and Input.is_action_just_pressed("enter"):
		show_item_ui(false)
		player.enable()
	
func _on_item_pickup(item_image, flavor_text):
	# set flavor text and image
	var texture_rect = item_ui.get_node("HBoxContainer/TextureRect")
	var flavor_label = item_ui.get_node("HBoxContainer/Label")
	texture_rect.texture = item_image
	flavor_label.text = flavor_text
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
