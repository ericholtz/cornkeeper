extends Area3D

@onready var player: CharacterBody3D = $"../../Player"
@onready var door_2: CSGBox3D = $"../Door2"
@onready var ben_bot: CharacterBody3D = $"../../BenBot"
@onready var chase_red_overlay: ColorRect = $"../../Player/head/Camera3D/CanvasLayer/ChaseRedOverlay"
@onready var directional_light_3d: DirectionalLight3D = $"../../Environment/DirectionalLight3D"


func _on_chase_trigger_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		return
	
	# disable controls
	player.disable()
	
	# enable red shader and red environment light
	chase_red_overlay.visible = true
	directional_light_3d.visible = true
	
	# spin player
	player.position = Vector3(self.position.x, player.position.y, self.position.z)
	var player_spin1 = create_tween()
	player_spin1.tween_property(player, "rotation_degrees", Vector3(0, 180, 0), 2)
	player_spin1.play()
	
	# show ben
	ben_bot.visible = true
	ben_bot.movement_speed = 5
	await get_tree().create_timer(4).timeout
	
	# turn player back around facing door
	var player_spin2 = create_tween()
	player_spin2.tween_property(player, "rotation_degrees", Vector3(0, 0, 0), 0.8)
	player_spin2.play()
	await player_spin2.finished
	
	# re-enable controls
	player.enable()
	
	# open door 2
	var door2_open = create_tween()
	door2_open.tween_property(door_2, "position", door_2.position - Vector3(4, 0, 0), 3)
	door2_open.play()
	await door2_open.finished
	
	# delete area so it can't be re-activated
	queue_free()
