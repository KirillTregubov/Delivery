extends CharacterBody2D
class_name Player

const SPEED = 200.0

@onready var map = $"../FloorTileMap"
var item = null
var is_interacting = false
var cancel_interacting = false
# var item_lock: Mutex = Mutex.new()
var task_queue = Task.create_queue() # as TaskQueue

#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_interact"):
		is_interacting = true
		cancel_interacting = false
	elif Input.is_action_just_released("ui_interact"):
		is_interacting = false
		cancel_interacting = false

	if task_queue.size > 0:
		var task = get_next_task()
		if task:
			var response = task.execute()
			if response is bool and response:
				task_queue.clear()
			print('response ', response)
	
	if cancel_interacting:
		is_interacting = false

func _physics_process(_delta: float) -> void:
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

func queue_task(task: Task, priority: Task.Priorities) -> void:
	cancel_interacting = true
	task_queue.add_task(task, priority)

func get_next_task() -> Task:
	return task_queue.get_task()

func can_interact() -> bool:
	return is_interacting # and item_lock.try_lock()

func pickup_item(node: Node) -> bool:
	if (item):
		print("Already holding item")
		return false
	
	item = node
	add_child(item)
	# TODO: handle directions
	item.position = Vector2.ZERO
	item.position.y += 10
	item.position.x -= 8
	return true

func get_item(item_type = null) -> Node:
	if not (item and not item_type or (item.has_meta("item_type") and item.get_meta("item_type") == item_type)):
		return null
	
	return item

func remove_item() -> void:
	if not item:
		return
	
	remove_child(item)
	item = null
