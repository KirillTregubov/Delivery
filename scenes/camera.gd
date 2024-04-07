extends Camera2D

const ZOOM_MAX = 2
const MIN_SCALING = 2

@export var ZOOM_SPEED = 10
var TARGET_SIZE = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
var target_zoom = 1.0
var smooth_zoom = 1.0

func change_zoom(new_zoom: float) -> void:
	#print()
	set_zoom(Vector2(new_zoom, new_zoom))
	#print('zoom ', zoom, ' -> ', new_zoom)
	#zoom = Vector2(new_zoom, new_zoom)

func size_changed() -> void:
	#print(zoom)
	#print(get_viewport().size)
	#print(TARGET_SIZE)
	#print('changed')
	var new_zoom = max(get_viewport().size.x / TARGET_SIZE.x, get_viewport().size.y / TARGET_SIZE.y)
	#print('new zoom ', new_zoom)
	
	#var zoom_base = 1
	#
	#if new_zoom <= MIN_SCALING:
		#zoom_base = 1
	#else:
		#zoom_base = int(new_zoom / MIN_SCALING)
	#
	#print('base ', zoom_base)
	
	#var diff = (new_zoom - int(new_zoom)) / 2
	#if (((int(new_zoom) - 1) % 2) == 1):
		#diff = diff + 0.5
	#print('diff', diff)
	
	change_zoom(max(new_zoom / 2, 1))
	return
	
	#if new_zoom <= MIN_SCALING:
		#change_zoom(1)
	#if ((int(new_zoom) - 1) % 2) == 0:
		## zoom to 2
		#print('zoom to 2')
		#var diff = (new_zoom - int(new_zoom)) / 5
		#change_zoom(zoom_base + 1 + diff)
		#pass
	#else:
		## zoom to 1
		#print('zoom to 1')
		#
		#pass
	#
	#return
	#
	#if new_zoom.y <= MIN_SCALING:
		#new_zoom.y = 1

	#change_zoom(Vector2(min(new_zoom.x, ZOOM_MAX), min(new_zoom.y, ZOOM_MAX)))
	#if new_zoom.x > MIN_SCALING and new_zoom.y > MIN_SCALING:
		#change_zoom(new_zoom)
	#else:
		#change_zoom(Vector2(1, 1))

	#zoom = Vector2(min(get_viewport().size.x / TARGET_SIZE.x, ZOOM_MAX), min(get_viewport().size.y / TARGET_SIZE.y, ZOOM_MAX))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().set_min_size(TARGET_SIZE)
	
	size_changed()
	get_viewport().connect("size_changed", size_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#smooth_zoom = lerp(smooth_zoom, target_zoom, ZOOM_SPEED * delta)
	#if smooth_zoom != target_zoom:
		#print('updating zoom. curr: ', zoom, ' smooth: ', smooth_zoom, ' target: ', target_zoom)
		#set_zoom(Vector2(smooth_zoom, smooth_zoom))
	pass
