extends Node2D
class_name SalmonSushi

func update_position() -> void:
	position += Vector2(0, -13)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("item_type", "SalmonSushi")

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
