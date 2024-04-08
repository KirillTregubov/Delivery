extends CharacterBody2D

const SPEED = 200.0

@onready var map = $"../FloorTileMap"

#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var direction: Vector2i = Vector2i.ZERO
	# var target_position: Vector2 = Vector2.ZERO

	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	
	if up and not down:
		direction.y = -1
		velocity.y = -SPEED
	elif down and not up:
		direction.y = 1
		velocity.y = SPEED
	
	if left and not right:
		direction.x = -1
		velocity.x = -SPEED
	elif right and not left:
		direction.x = 1
		velocity.x = SPEED

	if direction.x == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED / 2)
	if direction.y == 0:
		velocity.y = move_toward(velocity.y, 0, SPEED / 2)
	
	if direction != Vector2i.ZERO and velocity.abs().x == SPEED and velocity.abs().y == SPEED:
		velocity = velocity * 0.75

	# if direction:
	# 	var cur_cell = map.local_to_map(position)
	# 	print("current: ", cur_cell)
	# 	var new_cell = cur_cell + direction
	# 	print("new: ", new_cell)
	# 	target_position = map.map_to_local(new_cell)
	
	# if target_position:
	# 	print("target_position: ", target_position)

	move_and_slide()
