extends Node2D
class_name RicePot

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

const COOKING_TIME = 6
var elapsed_time: int = 0

func timer_finished() -> void:
	elapsed_time += 1
	label.text = "%ds" % elapsed_time
	if (elapsed_time >= COOKING_TIME):
		timer.stop()
		label.text = "Done"

func start() -> void:
	elapsed_time = 0
	timer.connect("timeout", timer_finished)
	timer.wait_time = 1.0
	timer.start()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.position.y -= 22

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
