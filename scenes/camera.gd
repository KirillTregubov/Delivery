extends Camera2D

var TARGET_SIZE = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
var SCALE: float = 1.0
const MIN_SCALING: int = 1

func scale_window():
	var window := get_window() as Window
	var retina_scale = DisplayServer.screen_get_scale()
	if (window.content_scale_factor != retina_scale):
		SCALE = retina_scale / window.content_scale_factor
		window.size = window.size * SCALE
		window.move_to_center()

func change_zoom(new_zoom: float) -> void:
	set_zoom(Vector2(new_zoom, new_zoom))

func size_changed() -> void:
	var new_zoom = max(get_viewport().size.x / TARGET_SIZE.x, get_viewport().size.y / TARGET_SIZE.y)
	change_zoom(max(new_zoom / 2, MIN_SCALING * SCALE))

func _ready() -> void:
	scale_window()
	get_window().set_min_size(TARGET_SIZE * SCALE)
	
	size_changed()
	get_viewport().connect("size_changed", size_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	##smooth_zoom = lerp(smooth_zoom, target_zoom, ZOOM_SPEED * delta)
	##if smooth_zoom != target_zoom:
		##print('updating zoom. curr: ', zoom, ' smooth: ', smooth_zoom, ' target: ', target_zoom)
		##set_zoom(Vector2(smooth_zoom, smooth_zoom))
	#pass
