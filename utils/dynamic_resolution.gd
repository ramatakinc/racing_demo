extends Spatial

const target_fps := 60.0
const min_scale := 0.25
const rescale_interval := 1.0

var max_scale := 1.0
var fps_sum := 0.0
var fps_sum_n := 0
var time_since_last_rescale := 0.0
var cur_scale := 1.0
var at_target_fps := 0
var loops := 0
var fps_sum_offset := 0

func _process(_delta):
	if Input.is_action_just_released("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	var fps := Engine.get_frames_drawn()

	fps_sum += fps
	fps_sum_n += 1
	
	time_since_last_rescale += _delta
	if time_since_last_rescale > rescale_interval:
		time_since_last_rescale = 0.0
		
		var avg := (fps_sum - fps_sum_offset) / fps_sum_n
		fps_sum_offset = fps_sum
		fps_sum = 0.0
		fps_sum_n = 0
		
		if loops < 3:
			loops += 1
			print("Too early for rescale")
			return
		
		print("FPS: " + str(avg))
		if avg == target_fps:
			at_target_fps += 1
		else:
			at_target_fps = 0
			
		var new_scale = cur_scale
		
		if avg < target_fps:
			new_scale /= 1.15
			
		if at_target_fps > 5 and cur_scale < 0.8:
			new_scale *= 1.15
		
		new_scale = clamp(new_scale, min_scale, max_scale)
				
		if new_scale != cur_scale:
			print("Setting resolution scale to: " + str(new_scale) + " from " + str(cur_scale))
			ProjectSettings.set_setting("rendering/quality/3d/resolution_scale", new_scale)
			cur_scale = new_scale

