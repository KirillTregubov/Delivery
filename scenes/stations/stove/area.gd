extends Area2D

var player: Player
@onready var placed_items: Node2D = $"../PlacedItems"
@onready var rice_pot: PackedScene = preload ("res://scenes/items/RicePot/rice_pot.tscn")

func place_item() -> bool:
	var item = player.get_item()
	if item and item.has_meta("targets") and item.get_meta("targets").find("Stove") != - 1:
		if placed_items.get_child_count() > 0:
			print("Already placed item")
			return false
		player.remove_item()
		var new_item = rice_pot.instantiate() as RicePot
		placed_items.add_child(new_item)
		new_item.name = "Pot"
		new_item.position.y -= 16
		new_item.position.x -= 4
		return true
	
	return false

func pickup_item() -> bool:
	var item = placed_items.get_child(0)
	# .has_meta("item_type") and item.get_meta("item_type") == "RicePot"
	if item and item.is_done():
		placed_items.remove_child(item)

		if player.pickup_item(item):
			item.finish()
			return true
		else:
			placed_items.add_child(item)
			return false
	
	return false
	# if item:
	# 	player.reset_interact()
	# 	player.add_item(item)
	# 	item.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player and player.can_interact():
		var callback: Callable
		if placed_items.get_child_count() == 0:
			callback = place_item
		else:
			callback = pickup_item
		player.queue_task(Task.new(callback), Task.Priorities.HIGH)

func _on_body_entered(body):
	if typeof(body) == typeof(Player):
		player = body

func _on_body_exited(body):
	if body == player:
		player = null
