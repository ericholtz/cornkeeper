extends Area3D

@onready var main = get_tree().get_current_scene()
@onready var ben_bot: CharacterBody3D = $"../../BenBot"

func _on_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		return
	ben_bot.movement_speed = 0
	main.player.disable()
	main.show_end_ui()
	main.toggle_chase_music(false)
	main.game_over = true
