extends Node2D
class_name RiceJar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("item_type", "RiceJar")
	set_meta("targets", ["Stove"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
