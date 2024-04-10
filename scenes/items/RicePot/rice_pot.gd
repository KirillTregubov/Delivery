extends Node2D
class_name RicePot

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

enum State {IDLE, COOKING, DONE, FINISHED}

const COOKING_TIME = 6
var elapsed_time: int = 0
var state: State = State.IDLE

func timer_finished() -> void:
	elapsed_time += 1
	label.text = "%ds" % elapsed_time
	if (elapsed_time >= COOKING_TIME):
		timer.stop()
		label.text = "Done"
		state = State.DONE

func start() -> void:
	if state != State.IDLE:
		return
	state = State.COOKING
	elapsed_time = 0
	timer.connect("timeout", timer_finished)
	timer.wait_time = 1.0
	timer.start()

func is_done() -> bool:
	return state == State.DONE

func finish() -> void:
	if state != State.DONE:
		return
	state = State.FINISHED
	label.visible = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("item_type", "RicePot")
	state = State.IDLE
	label.position.y -= 22
	print('starting')
	start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
