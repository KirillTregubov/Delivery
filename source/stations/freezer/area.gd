extends Area2D

var player: Player
@onready var salmon_fish: PackedScene = preload ("res://source/items/SalmonFish/salmon_fish.tscn")

func pickup_item() -> bool:
	return player.pickup_item(salmon_fish.instantiate())

# Called when the node enters the scene tree for the first time.
# func _ready() -> void:
# 	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player and player.can_interact():
		player.queue_task(Task.new(pickup_item), Task.Priorities.LOW)

func _on_body_entered(body: Node2D) -> void:
	if typeof(body) == typeof(Player):
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
