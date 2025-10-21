extends Node3D

@export var sprite_texture: CompressedTexture2D = null
@export_multiline var description: String = ""

@onready var sprite = $Sprite3D
@onready var root = get_tree().get_current_scene()

signal item_pickup(item_image, flavor_text)

func _ready() -> void:
	sprite.texture = sprite_texture

func _on_body_entered(body: Node3D) -> void:
	emit_signal("item_pickup", sprite_texture, description)
