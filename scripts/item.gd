extends Node3D

@export var sprite_texture: CompressedTexture2D = null
@export_multiline var description: String = ""

@onready var sprite = $Sprite3D
@onready var root = get_tree().get_current_scene()

signal item_pickup(item, item_image, flavor_text)

func _ready() -> void:
	sprite.texture = sprite_texture

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		emit_signal("item_pickup", self, sprite_texture, description)
	
func remove():
	call_deferred("queue_free")
