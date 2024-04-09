extends Area2D

var player: Player
@onready var placed_items: Node2D = $"../PlacedItems"
@onready var rice_pot: PackedScene = preload ("res://scenes/items/RicePot/rice_pot.tscn")

func callback() -> void:
	var item = player.get_item(typeof(RiceJar))
	if item:
		player.reset_interact()
		if placed_items.get_child_count() > 0:
			print("Already placed item")
			return
		player.remove_item()
		var new_item = rice_pot.instantiate() as RicePot
		placed_items.add_child(new_item)
		new_item.name = "Pot"
		new_item.position.y -= 16
		new_item.position.x -= 4
		new_item.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player and player.can_interact():
		player.queue_task(Task.new('placing', callback), Task.Priorities.NORMAL)

func _on_body_entered(body):
	if typeof(body) == typeof(Player):
		player = body

func _on_body_exited(body):
	if body == player:
		player = null
