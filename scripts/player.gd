extends CharacterBody3D

@onready var head = $head
@onready var camera = $head/Camera3D
const CAM_FOV = 75
const JUMP_VELOCITY = 8
const WALK_SPEED = 5
const RUN_SPEED = 8.5
const LERP_SPEED = 8
const MOUSE_VELOCITY = 0.1

var speed = 5.0
var health = 100

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction = Vector3.ZERO
var running = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.fov = CAM_FOV
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-deg_to_rad(event.relative.x * MOUSE_VELOCITY))
		head.rotate_x(-deg_to_rad(event.relative.y * MOUSE_VELOCITY))
		head.rotation.x = clamp(head.rotation.x, -PI/2, PI/2)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var input_run = Input.is_action_pressed("run")
	if running != input_run:
		# increase the FOV slightly when running
		var fov_tween = create_tween()
		fov_tween.tween_property(camera, "fov", CAM_FOV + 5 if input_run else CAM_FOV, 0.15).from_current()
		
		if input_run:
			speed = RUN_SPEED
		else:
			speed = WALK_SPEED
		running = input_run
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var input_dir = Input.get_vector("left", "right", "up", "down")
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), LERP_SPEED * delta)
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func jump():
	pass
