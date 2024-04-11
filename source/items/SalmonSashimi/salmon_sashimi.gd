extends Node2D
class_name SalmonSashimi

@onready var sushi = preload ("res://source/items/SalmonSushi/salmon_sushi.tscn")

func update_position() -> void:
	position += Vector2(0, -13)

func merge(node: Node):
	if node.get_meta("item_type") == "RicePot":
		queue_free()
		var item = sushi.instantiate()
		print("here")
		print(item)
		print(item.get_meta("item_type"))
		return item
	
	return null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("item_type", "SalmonSashimi")
	set_meta("merges", "RicePot")

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
