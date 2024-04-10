extends Area2D

var player: Player
@onready var placed_items: Node2D = $"../PlacedItems"

func place_item() -> bool:
	var item = player.get_item()
	if item:
		if placed_items.get_child_count() > 0:
			print("Already placed item")
			return false
		player.remove_item()
		placed_items.add_child(item)
		item.position = Vector2.ZERO
		item.position.y -= 16
		return true
	
	return false

func pickup_item() -> bool:
	var item = placed_items.get_child(0)
	if item:
		placed_items.remove_child(item)
		if player.pickup_item(item):
			return true
		else:
			placed_items.add_child(item)
			return false
	return false

# Called when the node enters the scene tree for the first time.
# func _ready() -> void:
# 	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player and player.can_interact():
		var callback: Callable
		if placed_items.get_child_count() == 0:
			callback = place_item
		else:
			callback = pickup_item
		player.queue_task(Task.new(callback), Task.Priorities.NORMAL)

func _on_body_entered(body: Node2D) -> void:
	if typeof(body) == typeof(Player):
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
