extends Area3D

func _on_body_entered(body: Node3D) -> void:
	print("got here")
	if body.name != "Player":
		return
	print("now got here")
	
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
