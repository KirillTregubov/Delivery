extends Node2D
class_name RicePot

@onready var timer: Timer = $Timer
@onready var progress: TextureProgressBar = $TextureProgressBar

enum State {IDLE, COOKING, DONE, FINISHED}

const COOKING_TIME = 6
var elapsed_time: int
var state: State = State.IDLE

func timer_finished() -> void:
	elapsed_time += 1
	progress.value = elapsed_time
	# label.text = "%ds" % elapsed_time
	if (elapsed_time >= COOKING_TIME):
		timer.stop()
		# label.text = "Done"
		state = State.DONE

func start() -> void:
	if state != State.IDLE:
		return
	progress.visible = true
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
	progress.visible = false
	# label.visible = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("item_type", "RicePot")
	state = State.IDLE
	elapsed_time = 0
	progress.visible = false
	progress.position.y -= 20
	progress.min_value = 0
	progress.max_value = COOKING_TIME
	progress.value = 0
	progress.step = 1 / COOKING_TIME
	start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
