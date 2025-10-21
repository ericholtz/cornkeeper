extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player: CharacterBody3D = $"../Player"

var movement_speed: float = 0.0

func _physics_process(_delta: float) -> void:
	navigation_agent_3d.set_target_position(player.position)
	var destination = navigation_agent_3d.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	velocity = direction * movement_speed
	move_and_slide()
