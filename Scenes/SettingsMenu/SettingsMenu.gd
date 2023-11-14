extends Control

func _on_volume_slide_value_changed(value):
	var master_bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)

func _on_sound_fx_volume_slide_value_changed(value):
	var soundFX_bus = AudioServer.get_bus_index("SoundFX")
	AudioServer.set_bus_volume_db(soundFX_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(soundFX_bus, true)
	else:
		AudioServer.set_bus_mute(soundFX_bus, false)
	
func _on_brightness_slide_value_changed(value):
	GlobalWorldEnvironment.environment.adjustment_brightness = value

func _on_back_pressed():
	$CanvasLayer.visible = !$CanvasLayer.visible

func _on_fullscreen_check_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_borderless_check_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_v_sync_check_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)



