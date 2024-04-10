extends Node2D
class_name SalmonFish

@onready var progress: TextureProgressBar = $TextureProgressBar
const MAX_DURABILITY = 6
var current_durability: int

func cut() -> bool:
	print("cutting salmon fish")
	if current_durability > 0:
		current_durability -= 1
		progress.visible = true
		progress.value = current_durability

		if current_durability == 0:
			progress.visible = false
			# TODO: transform into fillets
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
	progress.step = 1 / MAX_DURABILITY

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
