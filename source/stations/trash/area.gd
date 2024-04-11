extends Area2D

var player: Player

func trash() -> bool:
	var item = player.get_item()
	if item:
		player.remove_item()
		item.queue_free()
		return true
	
	return false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player and player.can_interact():
		player.queue_task(Task.new(trash), Task.Priorities.CRITICAL)

func _on_body_entered(body: Node2D) -> void:
	if typeof(body) == typeof(Player):
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
