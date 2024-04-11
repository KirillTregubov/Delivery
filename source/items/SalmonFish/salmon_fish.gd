extends Node2D
class_name SalmonFish

@onready var progress: TextureProgressBar = $TextureProgressBar
@onready var sashimi = preload ("res://source/items/SalmonSashimi/salmon_sashimi.tscn")

const MAX_DURABILITY = 6
var current_durability: int

func update_position() -> void:
	position += Vector2(0, -16)

func is_done() -> bool:
	return current_durability == 0

func cut() -> bool:
	if current_durability > 0:
		current_durability -= 1
		progress.visible = true
		progress.value = current_durability

		if current_durability == 0:
			progress.visible = false
			visible = false
			var new_item = sashimi.instantiate()
			new_item.update_position()
			get_parent().add_child(new_item)
			queue_free()
		return true
	else:
		return false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("item_type", "SalmonFish")
	set_meta("targets", ["CuttingBoard"])
	current_durability = MAX_DURABILITY
	progress.visible = false
	progress.position.y -= 16
	progress.min_value = 0
	progress.max_value = MAX_DURABILITY
	progress.value = MAX_DURABILITY
	progress.step = 1.0 / MAX_DURABILITY

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
