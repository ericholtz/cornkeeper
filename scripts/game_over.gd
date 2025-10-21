extends Node2D

func _input(_event: InputEvent) -> void:
	# restart
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_file("res://scenes/GameMenu.tscn")
