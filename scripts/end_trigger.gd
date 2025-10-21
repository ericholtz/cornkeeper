extends Area3D

@onready var main = get_tree().get_current_scene()

func _on_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		return
	main.player.disable()
	main.show_end_ui()
	main.toggle_chase_music(false)
	get_tree().paused = true
