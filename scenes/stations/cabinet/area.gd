extends Area2D

var player: Player
@onready var rice_jar: PackedScene = preload ("res://scenes/items/RiceJar/rice_jar.tscn")

func callback() -> void:
	player.pickup_item(rice_jar.instantiate())

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player and player.can_interact():
		player.queue_task(Task.new('pickup', callback), Task.Priorities.HIGH)

func _on_body_entered(body: Node2D) -> void:
	if typeof(body) == typeof(Player):
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
